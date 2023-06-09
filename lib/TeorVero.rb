# frozen_string_literal: true

require_relative "TeorVero/version"
include Math



module TeorVero
  class Error < StandardError; end
  
  def self.provnaclass(x, none = 1)


  if x.is_a?(Integer)
    x=x.to_s + ' 1'

  end


  if x.is_a?(Array)
    if x.size==1
      return x, [1]
    end
    if !none.nil?


      return x
    else
      if x.size==2
        if x[0].sum!=1 and x[1][0]<1 and x[1][0]>0
          xx=x[0]
          xv=x[1]
        else
          xx=x[1]
          xv=x[0]
        end
      elsif x.size>2 and x[1].size==2
        xx=[]
        xv=[]

        for d in x do

          xv<< d.min
          xx<< d.max
        end
      end

      return xx,xv
    end

  end


  if x.is_a?(Hash)
    if !none.nil?
    x=x.values.map{|t| t.to_f}

    return x
    else
      xv=x.values.map{|t| t.to_f}
      xx=x.keys.map{|y| y.to_f}
      xx.uniq!

      return xx,xv
    end
  end


  if x.is_a?(String)
    x=x.gsub(/[^[-.\d+]]/,' ').split.map{|y| y.to_f}

    if x.size==1
      return x, [1]
    end


    if x.size==2 and (x[1]==1 or x[1]==0) and (none.nil?)

      xx=x[0,1]
      xv=x[1,1]

    else

      xv = x.select{|y| y<1 and y>0}
      xx = x.select{|y| y>=1 or y<=0}


      xx.uniq!
    end


    if !xx.size.zero? and !xv.size.zero? #and nune.nil?

      return xx, xv
    elsif !xx.size.zero? and xv.size.zero?

      return xx
    else

      return xv
    end

  end


end

def self.matojid(x , y=:None)

  begin
  s=0
  i=0

  y=provnaclass(y)
  x=provnaclass(x,y)

  if y.nil?
    y=x[1]
    x=x[0]

  end


  if ((y.sum==1 and (y[0]<=1 and y[0]>0) and (x[0].abs >=1 or x[0]==0) or (x.sum==1 and (x[0]<=1 and x[0]>0) and (y[0]==0 or y[0].abs >=1 )) ) and x.size==y.size )
   x.length.times do

    s=(s+x[i]*y[i]).round(12)
    i=i+1
   end


    return s

  else
    return 'Data Error'
  end
  rescue Exception
    return "Exception Error"
  end
end

def self.provDis(x)

  if x.is_a?(Integer)
    x=x*x
    return x
  end

  if x.is_a?(Array)
    if (x[0].is_a?(Float) or x[0].is_a?(Integer)) and (x[0]>=1 or x[0]<=0)
      x.map!{|t| t*t}

    elsif x[0].is_a?(Array)
      for d in x do
        if (d[0]>=1 or d[0]<=0)
          d.map!{|t| t*t}
        end
      end

    end

    return x
  end

  if x.is_a?(Hash)

    x=x.transform_values{ |v| v.to_f}
    k = x.keys
    b=true
    for d in k do
      if k.is_a?(Symbol) or k.join.gsub(/[[-.\d+]]/,' ').gsub(' ','')!=''
        b=false
        #x=x.transform_values{ |v| v*v}

      end





    end

    if !b
      if (x.values[0]>=1 or x.values[0]<=0)
         x=x.transform_values{ |v| v*v}
      end
    else

      x=x.transform_keys{ |v| v.to_f}
      if (x.keys[0]>=1 or x.keys[0]<=0)
         x=x.transform_keys{ |v| v*v}
      end
    end

    return x
  end
  if x.is_a?(String)
    x=x.gsub(/[^[-.\d+]]/,' ').split.map{|y| y.to_f}
    i=0
    for d in x do
      if x[i]>=1 or x[i]<=0
        x[i]=x[i]*x[i]

      end
      i+=1
    end

    return x.join(' ')
  end
end

def self.dispersion(x,y =:None)
  begin


  s = (matojid(x,y)*matojid(x,y)).round(12)

  x=provDis(x)

  y=provDis(y)

  return (matojid(x,y)-s).round(12)

  rescue Exception
    if matojid(x,y)=='Data Error'
      return 'Data Error'
    end
    return "Exception Error"
  end
end

def self.kvadrdev(x,y=:None)
  begin


      return Math.sqrt(dispersion(x,y)).round(12)

  rescue Exception
    if dispersion(x,y)=='Data Error'
      return 'Data Error'
    end
    return "Exception Error"
  end
end


def self.funcdistr(x,y =:None)
  begin
  s=[]
  i=0

  y=provnaclass(y)
  x=provnaclass(x,y)

  if y.nil?
    y=x[1]
    x=x[0]

  end

  if (y.sum==1 and (y[0]<1 and y[0]>0) and (x[0]==0 or x[0].abs >=1 )) and x.size==y.size and x.size >1
    h=Hash[]
    hi=0
    x.length.times do
      h[x[hi]]=y[hi]
      hi=hi+1
    end
    h=h.sort.to_h
    x=h.keys
    y=h.values


    sp=0
    sx="x<=#{x[0]}"
    s<<[sp,sx]
    (y.length-1).times do


      sp=(sp+y[i]).round(12)
      sx="#{x[i]}<x<=#{x[i+1]}"
      s<<[sp,sx]
      i=i+1

    end
    s<<[1,"x>#{x[-1]}"]

    return s

  elsif (x.sum==1 and (x[0]<1 and x[0]>0) and (y[0]==0 or y[0].abs >=1 )) and x.size==y.size and y.size>1
    h=Hash[]
    hi=0
    y.length.times do
      h[y[hi]]=x[hi]
      hi=hi+1
    end
    h=h.sort.to_h
    y=h.keys
    x=h.values
    sp=0
    sx="x<=#{y[0]}"

    s<<[sp,sx]
    (x.length-1).times do


      sp=(sp+x[i]).round(12)
      sx="#{y[i]}<x<=#{y[i+1]}"
      s<<[sp,sx]
      i=i+1

    end
    s<<[1,"x>#{y[-1]}"]

    return s
  else
    return 'Data Error'
  end
  rescue Exception
    return "Exception Error"
  end
end

  #функция факториала
def self.factorial(n)
  (1..n).inject(1){|f,i| f*i}
end

# Биномиальный закон распределения
# n - количество независимых событий
# k - количетво появления события
# p - вероятность появления одного события
def self.binomialDis(n, k, p)
  if (n.is_a? Integer) and (n > 0) and (k.is_a? Integer) and (k >= 0) and (p.is_a? Float) and (p < 1) and (p > 0) then
    return factorial(n) * p**k * (1 - p)**(n - k) / (factorial(k) * factorial(n - k))
  else
    return "Data entered incorrectly"
  end
end

#Биномиальное математическое ожидание
 def self.binExpectVal(n, p)
  if (n.is_a? Integer) and (n > 0) and (p.is_a? Float) and (p <= 1) and (p > 0) then
    return n * p
  else
    return "Data entered incorrectly"
  end
end

   #дисперсия биномиальной переменной
def self.binDisper(n, p)
  if (n.is_a? Integer) and (n > 0) and (p.is_a? Float) and (p <= 1) and (p > 0) then
    return n * p*(1 - p)
  else
    return "Data entered incorrectly"
  end
end

  def self.binStandardDev(n, p)
  if (n.is_a? Integer) and (n > 0) and (p.is_a? Float) and (p <= 1) and (p > 0) then
    return sqrt(n * p*(1 - p))
  else
    return "Data entered incorrectly"
  end
end




# Медиана
def self.median(arr)
  if arr.is_a?(Array)
    return nil if arr == []
    return arr[0] if arr.length == 1

    # Сортируем массив по возрастанию значений
    sorted_arr = arr.sort

    # Вычисляем индекс(ы) элемента(ов), соответствующего медиане
    n = sorted_arr.length
    mid = n / 2
    if n % 2 == 0
      # Если длина массива четная, то медиана - это среднее значение двух средних элементов
      return (sorted_arr[mid - 1] + sorted_arr[mid]) / 2.0
    else
      # Если длина массива нечетная, то медиана - это средний элемент
      return sorted_arr[mid]
    end
  else
    return "Data entered incorrectly"
  end

end


# Мода
def self.mode(arr)
  if arr.is_a?(Array)
    # Создаем пустой хэш для хранения количества вхождений каждого элемента
    counts = Hash.new(0)

    # Считаем количество вхождений каждого элемента массива
    arr.each do |elem|
      counts[elem] += 1
    end

    # Находим значение(я) с максимальным количеством вхождений
    max_count = counts.values.max
    modes = counts.select { |k, v| v == max_count }.keys.sort

    # Если все элементы массива уникальны, то моды нет
    if modes.length == arr.length
      return nil
    else
      return modes
    end
  else
    return "Data entered incorrectly"
  end
end

# Начальный момент
def self.starting_moment(arr, k)
  if arr.is_a?(Array) and k.is_a?(Integer)
    return nil if arr == []
    moment_k = 0
    arr.each do |x|
      moment_k += x**k
    end
    return moment_k / arr.length.to_f
  else
    return "Data entered incorrectly"
  end
end


# Центральный момент
def self.central_moment(arr, k)
  if arr.is_a?(Array) and  k.is_a?(Integer)
    mean = arr.sum / arr.length.to_f
    moment_k = 0
    arr.each do |x|
      moment_k += (x - mean)**k
    end
    return moment_k / arr.length.to_f
  else
    return "Data entered incorrectly"
  end
end


# Асимметрия
def self.skewness(arr)
  if arr.is_a?(Array)
    return nil if arr == []
    n = arr.length
    return 0.0 if n == 1
    mean = arr.sum / n.to_f
    variance = arr.sum { |x| (x - mean)**2 } / (n - 1).to_f
    standard_deviation = Math.sqrt(variance)

    numerator = arr.sum { |x| (x - mean)**3 }
    denominator = n * standard_deviation**3

    return numerator / denominator
  else
    return "Data entered incorrectly"
  end
end


# Эксцесс
def self.excess(arr)
  if arr.is_a?(Array)
    n = arr.length
    return nil if n < 4 # нельзя найти эксцесс для массива с менее чем 4 элементами

    # находим выборочное среднее
    m = arr.reduce(:+) / n.to_f

    # находим выборочное среднее кубов отклонений
    m3 = arr.reduce(0) { |sum, x| sum + (x - m)**3 } / n.to_f

    # находим стандартное отклонение
    s = Math.sqrt(arr.reduce(0) { |sum, x| sum + (x - m)**2 } / (n - 1))

    # вычисляем эксцесс
    return (m3 - 3*m*s**2 - m**3) / s**4
  else
    return "Data entered incorrectly"
  end
end

  #Дальше код
end

