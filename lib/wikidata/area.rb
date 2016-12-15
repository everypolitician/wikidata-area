require "wikidata/area/version"

module Wikidata
  class Area
    SKIP = %i(P17 P18 P242 P910).to_set
    # TODO, reinstate this once Wikisnakker handles co-ordinates
    SKIP << :P625

    WANT = {
      P31:  :type,
      P571: :start_date,
      P576: :end_date,
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
      item.labels.map { |k, v| ["name__#{k.to_s.gsub('-','_')}", v[:value]] }.to_h
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
