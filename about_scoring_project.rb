require File.expand_path(File.dirname(__FILE__) + '/edgecase')

def score(dice)

  result = 0
  dice = dice.sort
  numbers = Array.new
  dice.each { |i|
    numbers[i] = dice.select { |j| j == i}
  }
  i = 0
  numbers.each do |num|
    i = i + 1
    if(num.nil?)
      next
    end
    if(num.count >= 3)
      result = (i-1) == 1? result + 1000 : result + (i-1)*100;
      if num.size > 3
        result = case (i-1)
        when 1 then result + 100 * (num.size - 3)
        when 5 then result + 50 * (num.size - 3)
        end
      end
    else
      if (i-1) == 1
        result = result + 100 * (num.count)
      end
      if (i-1) == 5
        result = result + 50 * (num.count)
      end
    end
  end
  result
 end


class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
