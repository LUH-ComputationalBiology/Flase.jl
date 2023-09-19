using Blink
using PlotlyJS
using Random
using Test



# START APP BY TYPING 'julia> include("GUI_Flase.jl")'

function linescatter2()  # this function makes a plot in the app. replace random testarray by real coordinates from simulation
    
    Random.seed!()
    testarray = rand(0:100, 100, 2)
        trace1 = scatter(;x=testarray[:,1], y=testarray[:,2], mode="markers",name="Items")
    testarray2=rand(0:100,20,2)
        trace2 = scatter(;x=testarray2[:,1],y=testarray2[:,2],mode="markers",name="Collectors")
        
        plot([trace1,trace2])
    end

function runSimulation()   

  runsim(simulation)
end

    w = Window() # Opens a new windows. App works correctly only if started in given order: functions->new window->handles

    handle(w, "press") do args   #  'press' handle is invoked by pressing 'start finite simulation' with default parameters. in a new window runs plot of a random coordinates array
        
        w = Window()
        body!(w,linescatter2())
    end
    handle(w,"press2") do args    #  'press2' handle is invoked if manual parameters are selected. args contains a vector with input parameters from app. current value of '2,3' is a place holder
      outputArray = [2,3]         # may be used to vary simulation 
      outputArray = args
      @show args
      
      println(outputArray)    # 'press3' handle runs a simulation in a shell. If not starting run a test '@testset "Testing" begin   include("test/test_Simulation.jl")   end'
    end
    handle(w,"press3") do args
      
      runSimulation()
    end




#body! runs the html code in an already opened window. 'raw' before """ prevented false escape sequences.  

body!(w,raw"""<head><title>FLASE - Diffusive collector-item model</title>     
<style>
sub {font-size:smaller; vertical-align:sub;}
fieldset {
  display: block;
  margin-left: 2px;
  margin-right: 2px;
  padding-top: 0.35em;
  padding-bottom: 0.625em;
  padding-left: 0.75em;
  padding-right: 0.75em;
  border: 2px groove;
  width:600px ;
}
body {
font-family: Arial;
  font-size:12px;
  text-align: left;
}



label {
width: 100px;
float: left;
text-align: right;
margin-right: 5px;
}

input {
width: 150px;
font-size: 12px;
display:block;
border: 1px solid black;
}
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    
  }
  .image {
   
    width:60px;
    height:50px;
    position:absolute;
    right:160px;
    }
  .green-button {
    width: 300px;
    height: 50px;
    background-color: green;
    color: white;
    font-size: 16px;
    border: none;
    margin-bottom: 20px;
    position:absolute;
    left: 0px;
  }
  .blue-button {
    width: 100px;
    height: 50px;
    background-color: blue;
    color:white;
    font-size: 16px;
    border:none;
    margin-bottom: 20px;
    position: relative;
    left: -30px;

  }
  .raw {
    display: flex;
    justify-content: space-between;
    margin-bottom: 100px;
  }

  
  
</style>
<script>   <!-- Part with javascript -->


  var Dstartwert = 20;    <!-- Dogs -->
  var Sstartwert = 100;   <!-- Sheeps -->
  

  function toggleTextFields() {                 <!-- default/manual -->
    var textField1 = document.getElementById("Parameter1");
    var textField2 = document.getElementById("Parameter2");
    
    if (textField1.disabled && textField2.disabled) {
      textField1.disabled = false;
      textField2.disabled = false;
    } else {
      textField1.disabled = true;
      textField2.disabled = true;
      textField1.value = Dstartwert;
      textField2.value = Sstartwert;
    }
  }
   function greenButton(){
    var textField1 = document.getElementById("Parameter1");
    var textField2 = document.getElementById("Parameter2");
    var outputArray = [];

    outputArray.push([+textField1.value]);
    outputArray.push([+textField2.value]);
    if (textField1.disabled && textField2.disabled){          <!-- textfields are disabled if a default simulation is gonna run.  -->
      Blink.msg("press", "")
    } else{
      Blink.msg("press2", outputArray)                        <!-- In else case a simulation with given parameters should run. Actually an array with input is send to julia -->
    }
   
   } 
  
  function openLink() {
    var linkURL = "https://gitlab.gwdg.de/MSc/flase/uploads/88b35ae75e67d10dbd5a0e76ca3cf737/physics.pdf";  
    window.open(linkURL, "_blank");
  }
  function openLink1() {
    var linkURL = "https://github.com/JuliaGizmos/Blink.jl.git";  
    window.open(linkURL, "_blank");
  }
  function openLink2() {
    var linkURL = "https://github.com/BeastyBlacksmith/Flase.jl.git";  
    window.open(linkURL, "_blank");
  }
  </script>
</head>
<body >

<br>
<div class="container">
<div class="row">
       
    
  <button class="green-button" onclick="greenButton()">Start Finite Simulation</button>
  <button class="blue-button" onclick='Blink.msg("press3", "")'>Simulation in Shell</button>
  <img class="image" src="https://raw.githubusercontent.com/JuliaLang/julia-logo-graphics/master/images/julia-logo-color.png" alt="Bildbeschreibung">
  
  
</div>
</div>
<br>
<br>



<div class:"container">
<div class:"row">
<fieldset>

  <legend>Set Parameters</legend>
  <label for="Parameter1">N<sub>D</sub> Collectors:</label>
  <input type="text" id="Parameter1" value="20" disabled>
  
  <br>
  
  <label for="Parameter2">N<sub>S</sub> Items:</label>
  <input type="text" id="Parameter2" value="100" disabled>
  
  <br>
  
  <button onclick="toggleTextFields()">Default/Manual</button>
</fieldset>
</div>
</div>

<br>
<fieldset>
<legend>Help Section</legend>
<button onclick="openLink()" >Physics behind simulation</button>
<button onclick="openLink1()">Blink.jl</button>
<button onclick="openLink2()">Flase.jl</button>
</fieldset>




</body>""");


