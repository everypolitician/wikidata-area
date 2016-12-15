require 'test_helper'

class Wikidata::AreaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Wikidata::Area::VERSION
  end

  # TODO: don't test against live data!
  def test_live_data
    data = Wikidata::Areas.new(ids: %w(Q3402163 Q3025278)).data

    assert_equal 2, data.count
    kesklinn = data.find { |a| a[:id] == 'Q3025278' }
    assert_includes kesklinn['name__en'], 'Kesklinn'
    assert_includes kesklinn['name__et'], 'Valimisringkond'
  end
end
