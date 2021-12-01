'# MWS Version: Version 2018.0 - Oct 26 2017 - ACIS 27.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 3 fmax = 8
'# created = '[VERSION]2018.0|27.0.2|20171026[/VERSION]


'@ use template: Antenna - Planar.cfg

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Celsius"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With
ThermalSolver.AmbientTemperature "0"
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "3", "8"
Dim sDefineAt As String
sDefineAt = "3;5.5;8"
Dim sDefineAtName As String
sDefineAtName = "3;5.5;8"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")
Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)
Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)
' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .MonitorValue  zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .MonitorValue  zz_val
    .Create
End With
' Define Power flow Monitors
With Monitor
    .Reset
    .Name "power ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerflow"
    .MonitorValue  zz_val
    .Create
End With
' Define Power loss Monitors
With Monitor
    .Reset
    .Name "loss ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerloss"
    .MonitorValue  zz_val
    .Create
End With
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .MonitorValue  zz_val
    .ExportFarfieldSource "False"
    .Create
End With
Next
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "Tetrahedral"
End With
'set the solver type
ChangeSolverType("HF Frequency Domain")

'@ define material: Copper (annealed)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1"
.Mu "1.0"
.Kappa "5.8e+007"
.TanD "0.0"
.TanDFreq "0.0"
.TanDGiven "False"
.TanDModel "ConstTanD"
.KappaM "0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstTanD"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "Nth Order"
.DispersiveFittingSchemeMu "Nth Order"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.FrqType "all"
.Type "Lossy metal"
.SetMaterialUnit "GHz", "mm"
.Mu "1.0"
.Kappa "5.8e+007"
.Rho "8930.0"
.ThermalType "Normal"
.ThermalConductivity "401.0"
.HeatCapacity "0.39"
.MetabolicRate "0"
.BloodFlow "0"
.VoxelConvection "0"
.MechanicsType "Isotropic"
.YoungsModulus "120"
.PoissonsRatio "0.33"
.ThermalExpansionRate "17"
.Colour "1", "1", "0"
.Wireframe "False"
.Reflection "False"
.Allowoutline "True"
.Transparentoutline "False"
.Transparency "0"
.Create
End With

'@ new component: component1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "component1"

'@ define brick: component1:path

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "path" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-length/2", "length/2" 
     .Yrange "-length/2", "length/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define material: Rogers RT5880 (lossy)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Material
     .Reset
     .Name "Rogers RT5880 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.2"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0009"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.20"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ define brick: component1:substate

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "substate" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-20", "20" 
     .Yrange "-20", "20" 
     .Zrange "-0.787", "0" 
     .Create
End With

'@ delete shape: component1:path

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:path"

'@ define brick: component1:path

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "path" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-length/2", "length/2" 
     .Yrange "-length/2", "length/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ align wcs with edge and face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:substate", "2" 
Pick.PickEdgeFromId "component1:substate", "7", "7" 
WCS.AlignWCSWithSelected "EdgeAndFace"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "xp(2)", "0" 
     .Yrange "0-0.5*2.38", "0.5*2.38" 
     .Zrange "0", "0.035" 
     .Create
End With


'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0" 


'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "u", "90.0" 


'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0" 


'@ set wcs properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With WCS
     .SetNormal "0", "1", "0"
     .SetOrigin "-20", "0", "-0.787"
     .SetUVector "0", "0", "-1"
End With


'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "u", "-(90.0)" 


'@ align wcs with face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ForceNextPick 
Pick.PickFaceFromId "component1:substate", "1" 
WCS.AlignWCSWithSelected "Face"


'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "component1:solid1", "2" 


