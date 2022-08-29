# Use for calculating sqr distance

#first we need a new structure

struct MQD end 

#then compute the function that takes imput from object sheep::Sheeps 
function sqr_dist(sheep, sheep1, gridsizestorage) 

d1 =min(abs(sheep[2][1] - sheep1[2][1]), gridsizestorage  - abs(sheep[2][1] - sheep1[2][1]))
d2 =min(abs(sheep[2][2] - sheep1[2][2]), gridsizestorage  - abs(sheep[2][2] - sheep1[2][2])) 

return d1*d1+d2*d2
end
 


function measure(::MQD, sheeps::Sheeps)   
#set a 3x3 Matrix for Test purpose. Result should be 3/4 
#setvariables counter(=unsigned Integer), mean(=Float64) to 0  


gridsizestorage = size(sheeps.grid)[1]

counter = 0
mean::Float64 = 0


for sheep in sheeps

    for sheep1 in sheeps



 
      mean += sheep[1] * sheep1[1] * SqrDist(sheep, sheep1, gridsizestorage)  
      counter += sheep[1] * sheep1[1] 

     end

end

return mean/counter
 

end 
