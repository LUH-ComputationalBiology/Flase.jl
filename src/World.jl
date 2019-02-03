struct World{F<:Number}
    boxsize::Base.RefValue{F}
end

const world = World( Ref(10.) )
