# frozen_string_literal: true

require_relative "TeorVero/version"

module TeorVero
  class Error < StandardError; end
  # Your code goes here...

  def self.provnaclass(x, none = 1)
  #Ответвленная функция на проверку класса задаваемой переменной и дальнейшего рассмотрения возможных ситуаций 
  #Когда мы получаем число то его мат ожидание будет равно этому же числу поэтому мы превращаем переменную х в строковый тип с вероятностью 1 и работает как со строкой функция которой описана ниже 
  if x.is_a?(Integer)
    x=x.to_s + ' 1'
    
  end 
  #Функция массива предлагает на рассмотрение несколько вариантов подачи массива данных в функцию . Это могут быть как два обычных массива переменных случайной величины и ее вероятностей, как и массив этих двух массивов, или это может быть один массив массивов массивы которого представляют из себя не два массива СВ и их вероятностей , а попарную комбинацию каждого значения СВ и его комбинации 
  if x.is_a?(Array)
    if x.size==1
      return x, [1]
    end 
    if !none.nil?
    
      p x
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
          
          xv<<d.min
          xx<<d.max
        end 
      end 
      
      return xx,xv
    end 
    
  end 
  #Хэщ по своей сути идентичен с массивом так как мы просто создаем массивы значений двух хэшей, либо можем взять один хэш, где его ключи это значения СВ, а его величины это вероятности, наоборот не поддерживается в связи с уникальностью ключей, как и случайных значений, что нельзя сказать о вероятности 
  if x.is_a?(Hash) 
    if !none.nil?
    x=x.values.map{|t| t.to_f}
    
    return x
    else 
      xv=x.values.map{|t| t.to_f}
      xx=x.keys.map{|y| y.to_f}
      xx.uniq!
      #p xx,xv
      return xx,xv
    end 
  end 
  
  #Строковый тип был самым необычным и одновременно обычным. Мы убираем все лишние символы кроме точки и тире так как это показатели отриц числа и веществ числа. Потом из полученого таким способом массива мы сортируем СВ и вероятности по определению, на вход могут подаваться как две строки, так и одна содержащая любую комбинацию данных чисел. Прошу заменить, что использование индексации чисел например x1=2 не будет выполняться поэтому мы воздерживаемся от таких возможных заданий переменных то есть автор сдох когда решал способ исключения всех возможных ситуаций, поэтому он запретил использовать индексацию, желательно вообще описание строк только цифрами, либо с переменными например "x=1 y=2 z=4", то без индексации "x1=1 x2=2 x3=4"
  if x.is_a?(String) 
    x=x.gsub(/[^[-.\d+]]/,' ').split.map{|y| y.to_f}
    #p x
    if x.size==1
      return x, [1]
    end 
    
    
    if x.size==2 and (x[1]==1 or x[1]==0) and (none.nil?)
      
      xx=x[0,1] 
      xv=x[1,1]
      
    else 
      
      xv = x.select{|y| y<1 and y>0}
      xx = x.select{|y| y>=1 or y<=0}
      #p xx
      
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
  #Выше описанные функции также следят за тем был ли использован y или нет, что можно заметить в описании, когда мы говорим о возможности использования одной переменной, где вторая сразу задается по умолчанию
  begin 
  s=0
  i=0
   
  y=provnaclass(y)
  x=provnaclass(x,y)
  #После сортировки по типам и превращению все в массивы мы готовы посчитать мат ожидание которое равняется сумме произведений Xi*Pi
  if y.nil?
    y=x[1]
    x=x[0]
   
  end
  
  #Данная проверка условий ставит рамки на задачу х и у, то есть пользователь мог ввести не х и у а ввести у и х, что меняет местами проверку условий на выполнение свойства распределения СВ
  if ((y.sum==1 and (y[0]<=1 and y[0]>0)) or (x.sum==1 and (x[0]<=1 and x[0]>0)) ) and x.size==y.size 
   x.length.times do 
    
    s=s+x[i]*y[i]
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
  #Ну эта проверка олицетворяет возведения в квадрат значений СВ чтобы найти мат ожидание от квадрата х 
  #Просто разные элементы как и в мат ожидании
  if x.is_a?(Integer)
    x=0
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
    
        
      end 
      
      
   
    
    
    end
    if !b
      if (x.values[0]>1 or x.values[0]<0) 
         x=x.transform_values{ |v| v*v}
      end 
    else 
      
      x=x.transform_keys{ |v| v.to_f}
      if (x.keys[0]>1 or x.keys[0]<0) 
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
    p x.join(' ')
    return x.join(' ')
  end 
end 

def self.dispersion(x,y =:None)
  begin 
  #Сама функция это буквально M(x^2)-(M(x))^2  
  s= matojid(x,y)*matojid(x,y)
  
  x=provDis(x) 
  y=provDis(y)
    
  return matojid(x,y)-s
    
  rescue Exception
    return "Exception Error"
  end 
end 

def self.kvadrdev(x,y)
  begin 
  Math.sqrt(dispersion(x,y)*dispersion(x,y))
  rescue Exception
    return "Exception Error"
  end 
end 

def self.funcdistr(x,y)
  begin 
  s=[]
  i=0
   
  y=provnaclass(y)
  x=provnaclass(x,y)
  
  if y.nil?
    y=x[1]
    x=x[0]
   
  end
  
  if (y.sum==1 and (y[0]<=1 and y[0]>0)) and x.size==y.size 
  sp=0
  sx="x<=#{x[0]}"
  s<<[sp,sx]
   (y.length-1).times do 
    
    
    sp=(y[i]+y[i+1]).round(1)
    sx="#{x[i]}<x<=#{x[i+1]}"
    s<<[sp,sx]
    i=i+1
    p s
   end 
    s<<[1,"x>#{x[-1]}"]
    p ' in y'
    p s
    return s
    #Комментарии ошибок можно думаю изменить или расширить это не критично
  elsif (x.sum==1 and (x[0]<=1 and x[0]>0)) and x.size==y.size 
  sp=0
  sx="x<=#{y[0]}"
    
  s<<[sp,sx]
   (x.length-1).times do 
    
    
    sp=(x[i]+x[i+1]).round(1)
    sx="#{y[i]}<x<=#{y[i+1]}"
    s<<[sp,sx]
    i=i+1
    p s
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
  #Дальше код
  
  
end
