require 'wikidata/area/version'

module Wikidata
  class Area
    SKIP = %i(
      P17 P18 P36 P47 P131 P163 P242 P373 P421 P610 P910 P935 P948 P982
      P1082 P1343 P1464 P1465 P1740 P1792 P2633
    ).to_set
    # TODO, reinstate this once Wikisnakker handles co-ordinates
    SKIP << :P625

    WANT = {
      P31:   :type,
      P41:   :flag, # TODO: fall back on P163
      P94:   :coat_of_arms,
      P300:  :iso_code,
      P571:  :start_date,
      P576:  :end_date,
      P580:  :start_date,
      P582:  :end_date,
      P856:  :website,
      P1365: :replaces,
      P1366: :replaced_by,
      P214:  :identifier__viaf,
      P227:  :identifier__gnd,
      P244:  :identifier__lcauth,
      P268:  :identifier__bnf,
      P402:  :identifier__openstreetmap,
      P646:  :identifier__freebase,
      P836:  :identifier__gss,
      P901:  :identifier__fips,
      P998:  :identifier__dmoz,
      P1417: :identifier__britannica,
      P1566: :identifier__geonames,
      P1617: :identifier__bbc_things,
      P1667: :identifier__tgn,
      P3221: :identifier__newyorktimes,
      P3417: :identifier__quora,
    }.freeze

    def initialize(item)
      @item = item
    end

    def data
      unknown_properties.each do |p|
        warn "Unknown property for #{item.id}: #{p} = #{item.send(p).value}"
      end

      base_data.merge(wanted_data).merge(names)
    end

    private

    attr_reader :item

    def base_data
      { id: item.id }
    end

    def names
      item.labels.map do |k, v|
        ["name__#{k.to_s.tr('-', '_')}", v[:value]]
      end.to_h
    end

    def unknown_properties
      item.properties.reject { |p| SKIP.include?(p) || WANT.key?(p) }
    end

    def wanted_properties
      item.properties.select { |p| WANT.key?(p) }
    end

    def wanted_data
      wanted_properties.map { |p| [WANT[p], item.send(p).value.to_s] }.to_h
    end
  end

  class Areas
    require 'wikisnakker'

    def initialize(ids:)
      @ids = ids
    end

    def data
      wikidata_areas.flat_map(&:data).compact
    end

    private

    attr_reader :ids

    def wikisnakker_items
      @wsitems ||= Wikisnakker::Item.find(ids)
    end

    def wikidata_areas
      @wdareas ||= wikisnakker_items.map { |i| Wikidata::Area.new(i) }
    end
  end
end
