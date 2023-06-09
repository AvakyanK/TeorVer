# frozen_string_literal: true

require "test_helper"

class TestTeorVero < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TeorVero::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_mat_disp_kvad_func
  #assert_equal true, true
    arrs = [[1,2,3],[0.1,0.7,0.2]]
    arrsm = [[1,-2,3],[0.1,0.7,0.2]]
    arr1 = [1,2,3]
    arr11 = [1,-2,3]
    arrerm = [-0.1,0.7,0.2]
    arrer = [0.1,0.7,0.4]
    arr2 = [0.1,0.7,0.2]
    hashp = {p1:0.1 ,p2:0.7 , 'p3'=>0.2 }
    hashx = {x1:1,x2: 2,x3: 3}
    hashs = {'1'=>'0.1',  2 =>0.7, 3=>0.2}
    strx = ' x=1 y =2 z=3'
    strp = '0.1, 0.7, :0.2'
    strob = '1 2 3 0.1 0.7 0.2'
    strobr = ' 0.1 0.7 0.2 1 2 3 '

    assert_equal TeorVer.funcdistr(arrs), [[0, "x<=1"], [0.8, "1<x<=2"], [0.9, "2<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(arrsm), [[0, "x<=-2"], [0.7, "-2<x<=1"], [0.8, "1<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(arr1,arr2),  [[0, "x<=1"], [0.8, "1<x<=2"], [0.9, "2<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(arr2,arr1),  [[0, "x<=1"], [0.8, "1<x<=2"], [0.9, "2<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(arr11,arr2), [[0, "x<=-2"], [0.7, "-2<x<=1"], [0.8, "1<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(hashs), [[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]
    assert_equal TeorVer.funcdistr(hashp,hashx),[[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]
    assert_equal TeorVer.funcdistr(hashx,hashp),[[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]
    assert_equal TeorVer.funcdistr(arrer), "Exception Error"
    assert_equal TeorVer.funcdistr(arrer, hashp), "Data Error"
    assert_equal TeorVer.funcdistr(arrer, arr2), "Data Error"
    assert_equal TeorVer.funcdistr(arrerm), "Exception Error"
    assert_equal TeorVer.funcdistr(arrerm, hashp), "Data Error"
    assert_equal TeorVer.funcdistr(arrerm, arr2), "Data Error"
    assert_equal TeorVer.funcdistr(arr1, arr1), "Data Error"
    assert_equal TeorVer.funcdistr(arr2, strx), [[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]
    assert_equal TeorVer.funcdistr(arr1, hashp), [[0, "x<=1"], [0.1, "1<x<=2"], [0.8, "2<x<=3"], [1, "x>3"]]
    assert_equal TeorVer.funcdistr(strob), [[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]
    assert_equal TeorVer.funcdistr(strobr), [[0, "x<=1.0"], [0.1, "1.0<x<=2.0"], [0.8, "2.0<x<=3.0"], [1, "x>3.0"]]


    assert_equal TeorVer.matojid(arr1, arr2), 2.1
    assert_equal TeorVer.matojid(arr2, arr1), 2.1
    assert_equal TeorVer.matojid(arrs), 2.1
    assert_equal TeorVer.matojid(strx, strp) , 2.1
    assert_equal TeorVer.matojid(strob), 2.1
    assert_equal TeorVer.matojid(strobr), 2.1
    assert_equal TeorVer.matojid(hashx, hashp), 2.1
    assert_equal TeorVer.matojid(hashs), 2.1
    assert_equal TeorVer.matojid(arrer), "Exception Error"
    assert_equal TeorVer.matojid(arrerm), "Exception Error"
    assert_equal TeorVer.matojid(arrerm, arr2), "Data Error"
    assert_equal TeorVer.matojid(arrerm, arr1), "Data Error"
    assert_equal TeorVer.matojid(arr11, arr2), -0.7
    assert_equal TeorVer.matojid(arr11, arr1), "Data Error"

    assert_equal TeorVer.dispersion(5), 0.0
    assert_equal TeorVer.dispersion([1,2,3], [0.1,0.7,0.2]), 0.29
    assert_equal TeorVer.dispersion([0.1,0.7,0.2], [1,2,3]), 0.29
    assert_equal TeorVer.dispersion(arrs), 0.29
    assert_equal TeorVer.dispersion(strx, strp) , 0.29
    assert_equal TeorVer.dispersion(strob), 0.29
    assert_equal TeorVer.dispersion(strobr), 0.29
    assert_equal TeorVer.dispersion(hashx, hashp), 0.29
    assert_equal TeorVer.dispersion(hashs), 0.29
    assert_equal TeorVer.dispersion(arrer), "Exception Error"
    assert_equal TeorVer.dispersion(arrerm), "Exception Error"
    assert_equal TeorVer.dispersion(arrerm, arr2), "Data Error"
    assert_equal TeorVer.dispersion(arrerm, arr1), "Data Error"
    assert_equal TeorVer.dispersion(arr11, arr2), 4.21
    assert_equal TeorVer.dispersion(arr11, arr1), "Data Error"

    assert_equal TeorVer.kvadrdev([1,2,3], [0.1,0.7,0.2]), 0.538516480713
    assert_equal TeorVer.kvadrdev([0.1,0.7,0.2], [1,2,3]), 0.538516480713
    assert_equal TeorVer.kvadrdev(arrs), 0.538516480713
    assert_equal TeorVer.kvadrdev(strx, strp) , 0.538516480713
    assert_equal TeorVer.kvadrdev(strob), 0.538516480713
    assert_equal TeorVer.kvadrdev(strobr), 0.538516480713
    assert_equal TeorVer.kvadrdev(hashx, hashp), 0.538516480713
    assert_equal TeorVer.kvadrdev(hashs), 0.538516480713
    assert_equal TeorVer.kvadrdev(arrer), "Exception Error"
    assert_equal TeorVer.kvadrdev(arrerm), "Exception Error"
    assert_equal TeorVer.kvadrdev(arrerm, arr2), "Data Error"
    assert_equal TeorVer.kvadrdev(arrerm, arr1), "Data Error"
    assert_equal TeorVer.kvadrdev(arr11, arr2), 2.051828452868
    assert_equal TeorVer.kvadrdev(arr11, arr1), "Data Error"
end

  def test_binomialDis_check1
    assert_equal 0.7290000000000001,  TeorVer.binomialDis(3, 0, 0.1)
  end

    def test_binomialDis_check2
    assert_equal 0.0010000000000000002,  TeorVer.binomialDis(3, 3, 0.1)
  end

  def test_binomialDis_check3
    assert_equal 0.027000000000000007,  TeorVer.binomialDis(3, 2, 0.1)
  end

  def test_binomialDis_wrong_data1
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis(-2, 2, 0.1)
  end

  def test_binomialDis_wrong_data2
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis(2, -2, 0.1)
  end

  def test_binomialDis_wrong_data3
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis(2, 2, 10)
  end

  def test_binomialDis_wrong_data4
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis(2, "data", 10)
  end

  def test_binomialDis_wrong_data5
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis("wrong data", 2, 10)
  end

  def test_binomialDis_wrong_data6
    assert_equal "Data entered incorrectly",  TeorVer.binomialDis(3, 2, "wrong data")
  end

  def test_binExpectVal_check1
    assert_equal 0.4,  TeorVer.binExpectVal(2, 0.2)
  end

  def test_binExpectVal_wrong_data1
    assert_equal "Data entered incorrectly",  TeorVer.binExpectVal(0, 0.2)
  end

  def test_binExpectVal_wrong_data2
    assert_equal "Data entered incorrectly",  TeorVer.binExpectVal(-6, 0.2)
  end

  def test_binExpectVal_wrong_data3
    assert_equal "Data entered incorrectly",  TeorVer.binExpectVal(4, 4)
  end

  def test_binExpectVal_wrong_data4
    assert_equal "Data entered incorrectly",  TeorVer.binExpectVal("wrong data", 0.2)
  end

  def test_binExpectVal_wrong_data5
    assert_equal "Data entered incorrectly",  TeorVer.binExpectVal(4, "wrong data")
  end

  def test_binDisper_chech1
    assert_equal 0.36000000000000004,  TeorVer.binDisper(4, 0.1)
  end

  def test_binDisper_wrong_data1
    assert_equal "Data entered incorrectly",  TeorVer.binDisper(0, 0.1)
  end

  def test_binDisper_wrong_data2
    assert_equal "Data entered incorrectly",  TeorVer.binDisper(16, 10)
  end

  def test_binDisper_wrong_data3
    assert_equal "Data entered incorrectly",  TeorVer.binDisper("wrong data", 10)
  end

  def test_binDisper_wrong_data4
    assert_equal "Data entered incorrectly",  TeorVer.binDisper(4, "wrong data")
  end

  def test_binStandardDev_check1
    assert_equal 0.6000000000000001,  TeorVer.binStandardDev(4, 0.1)
  end

  def test_binbinStandardDev_wrong_data1
    assert_equal "Data entered incorrectly",  TeorVer.binStandardDev("wrong data", 0.1)
  end

  def test_binStandardDev_wrong_data2
    assert_equal "Data entered incorrectly",  TeorVer.binStandardDev(-4, 0.1)
  end

  def test_binStandardDev_wrong_data3
    assert_equal "Data entered incorrectly",  TeorVer.binStandardDev(4, "wrong data")
  end

  def test_median_even
    assert_equal(5.5, TeorVer.median([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
  end

  def test_median_odd
    assert_equal(3, TeorVer.median([1, 2, 3, 4, 5]))
  end

  def test_median_nil
    assert_equal(nil, TeorVer.median([]))
  end

  def test_median_one
    assert_equal(1, TeorVer.median([1]]))
  end


  def test_mode_nil
    assert_equal(nil, TeorVer.mode([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
  end

  def test_mode_one
    assert_equal([3], TeorVer.mode([1, 3, 3, 3, 5]))
    assert_equal([8], TeorVer.mode([8, 1, 8, 3, 8, 8, 3, 3, 5]))
  end

  def test_mode_two
    assert_equal([1, 3], TeorVer.mode([1, 3, 3, 3, 5, 1, 1]))
    assert_equal([1, 3], TeorVer.mode([1, 3, 3, 3, 5, 1, 5, 1]))
  end

  def test_mode_three
    assert_equal([1, 3, 5], TeorVer.mode([3, 3, 5, 1, 5, 1]))
    assert_equal([1, 3, 9], TeorVer.mode([9, 1, 3, 9, 3, 1, 3, 5, 1, 9]))
  end


  def test_starting_moment_k_1
    assert_equal(3.0, TeorVer.starting_moment([1, 2, 3, 4, 5], 1))
    assert_equal(2.75, TeorVer.starting_moment([2, 2, 3, 4], 1))
    assert_equal(1.75, TeorVer.starting_moment([1, 2, 2, 2], 1))
  end

  def test_starting_k_2
    assert_equal(11.0, TeorVer.starting_moment([1, 2, 3, 4, 5], 2))
    assert_equal(8.25, TeorVer.starting_moment([2, 2, 3, 4], 2))
    assert_equal(3.25, TeorVer.starting_moment([1, 2, 2, 2], 2))
  end

  def test_starting_k_3
    assert_equal(45.0, TeorVer.starting_moment([1, 2, 3, 4, 5], 3))
    assert_equal(26.75, TeorVer.starting_moment([2, 2, 3, 4], 3))
    assert_equal(6.25, TeorVer.starting_moment([1, 2, 2, 2], 3))
  end

  def test_starting_moment_nil
    assert_equal(nil, TeorVer.starting_moment([], 1))
    assert_equal(nil, TeorVer.starting_moment([], 2))
    assert_equal(nil, TeorVer.starting_moment([], 3))
  end

  def test_central_moment
    data = [1, 2, 3, 4, 5]
    assert_in_delta(0, TeorVer.central_moment(data, 1), 0.001)
    assert_in_delta(2, TeorVer.central_moment(data, 2), 0.001)
    assert_in_delta(0, TeorVer.central_moment(data, 3), 0.001)
    assert_in_delta(6.8, TeorVer.central_moment(data, 4), 0.001)
  end

  def test_skewness_positive
    array = [1, 2, 3, 4, 5, 6, 87, 8, 9, 10, 11, 12]
    assert_equal(2.535, TeorVer.skewness(array).round(3))
  end

  def test_skewness_negative
    array = [1, 2, 3, 4, 5, 6, -87, 8, 9, 10, 11, 12]
    assert_equal(-2.563, TeorVer.skewness(array).round(3))
  end


  def test_skewness_zero
    array = [1, 2, 3, 4, 5]
    assert_equal(0.0, TeorVer.skewness(array))
  end

  def test_skewness_single_value
    array = [1]
    assert_equal(0.0, TeorVer.skewness(array))
  end

  def test_skewness_empty_array
    array = []
    assert_nil(TeorVer.skewness(array))
  end
end
