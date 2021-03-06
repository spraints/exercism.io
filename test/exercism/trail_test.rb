require './test/test_helper'

require 'exercism/named'
require 'exercism/exercise'
require 'exercism/trail'

class TrailTest < Minitest::Test

  attr_reader :trail, :one, :two

  def setup
    @trail = Trail.new('Go', ['one', 'two'], '/tmp')
    @one = Exercise.new('go', 'one')
    @two = Exercise.new('go', 'two')
  end

  def test_language
    assert_equal 'go', trail.language
  end

  def test_name
    assert_equal 'Go', trail.name
  end

  def test_catch_up_missed_exercise
    slugs = %w(chicken suit one garden two cake)
    trail = Trail.new('Go', slugs, '/tmp')

    exercise = trail.after(two, %w(chicken suit garden))
    assert_equal one, exercise
  end

  def test_after_last_exercise
    assert_nil trail.after(two, %w(one two))
  end

  def test_language_from_name_with_spaces
    trail = Trail.new('Common Lisp', [], '/tmp')
    assert_equal 'common-lisp', trail.language
  end
end
