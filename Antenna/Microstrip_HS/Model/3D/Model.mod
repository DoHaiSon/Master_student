'# MWS Version: Version 2018.0 - Oct 26 2017 - ACIS 27.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 3 fmax = 8
'# created = '[VERSION]2018.0|27.0.2|20171026[/VERSION]


'@ use template: Microstrip  Antenna.cfg

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Celsius"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
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
Solver.FrequencyRange "2", "3"
Dim sDefineAt As String
sDefineAt = "2.4"
Dim sDefineAtName As String
sDefineAtName = "2.4"
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
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")

'@ change solver type

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
ChangeSolverType "HF Time Domain"

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

'@ new component: component1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Component.New "component1"

'@ define brick: component1:Subtrate

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Subtrate" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-20", "20" 
     .Yrange "-20", "20" 
     .Zrange "-0.787", "0" 
     .Create
End With

'@ define brick: component1:Patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-L/2", "L/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ switch working plane

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Plot.DrawWorkplane "true"

'@ pick mid point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickMidpointFromId "component1:Subtrate", "1"

'@ activate local coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "local"

'@ activate global coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "global"

'@ activate local coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "local"

'@ align wcs with point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.AlignWCSWithSelected "Point"

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-10", "0" 
     .Yrange "-0.5*2.38", "0.5*2.38" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ boolean add shapes: component1:Patch, component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Patch", "component1:solid1"

'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "18"

'@ align wcs with point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.AlignWCSWithSelected "Point"

'@ define brick: component1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-7.5", "0" 
     .Yrange "-0.5", "0" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "component1:solid2", "1"

'@ pick end point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEndpointFromId "component1:Patch", "20"

'@ transform: translate component1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid2" 
     .Vector "0", "2.88", "0" 
     .UsePickedPoints "True" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "True" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ boolean subtract shapes: component1:Patch, component1:solid2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Subtract "component1:Patch", "component1:solid2"

'@ clear picks

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ClearAllPicks

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:Subtrate", "2"

'@ define extrude: component1:ground

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Extrude 
     .Reset 
     .Name "ground" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Mode "Picks" 
     .Height "0.035" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:Patch", "18"

'@ define port: 1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "20", "20" 
     .Yrange "-1.19", "1.19" 
     .Zrange "0", "0.035" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "2*2.38", "2*2.38" 
     .ZrangeAdd "0.787", "6*0.787" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.FrequencyRange "3", "8"

'@ define boundaries

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "magnetic"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
End With

'@ define time domain solver parameters

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define farfield monitor: farfield (f=5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "5" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-33.626929909091", "33.626929909091", "-33.626929909091", "33.626929909091", "-14.448929909091", "18.383929909091" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ define monitor: e-field (f=5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "e-field (f=2.4)" 
End With 
With Monitor 
     .Reset 
     .Name "e-field (f=5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "5" 
     .UseSubvolume "False" 
     .Coordinates "Free" 
     .SetSubvolume "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define monitor: loss (f=5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "loss (f=2.4)" 
End With 
With Monitor 
     .Reset 
     .Name "loss (f=5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "5" 
     .Create 
End With

'@ delete monitor: farfield (f=2.4)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Monitor.Delete "farfield (f=2.4)"

'@ define monitor: h-field (f=5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "h-field (f=2.4)" 
End With 
With Monitor 
     .Reset 
     .Name "h-field (f=5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "5" 
     .UseSubvolume "False" 
     .Coordinates "Free" 
     .SetSubvolume "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ farfield plot options

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With FarfieldPlot 
     .Plottype "3D" 
     .Vary "angle1" 
     .Theta "90" 
     .Phi "90" 
     .Step "5" 
     .Step2 "5" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "-1" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Directivity" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "unknown" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Linear" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 
     .AddCut "lateral", "0", "1"  
     .AddCut "lateral", "90", "1"  
     .AddCut "polar", "90", "1"  
     .StoreSettings
End With

'@ delete shape: component1:Patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:Patch"

'@ pick edge

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickEdgeFromId "component1:Subtrate", "1", "1"

'@ pick mid point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickMidpointFromId "component1:Subtrate", "1"

'@ activate global coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "global"

'@ activate local coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "local"

'@ set wcs properties

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With WCS
     .SetNormal "0", "0", "1"
     .SetOrigin "10", "-1.19", "0"
     .SetUVector "1", "0", "0"
End With

'@ align wcs with edge

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.AlignWCSWithSelected "EdgeCenter"

'@ activate global coordinates

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.ActivateWCS "global"

'@ clear picks

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.ClearAllPicks

'@ define brick: component1:Patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-10", "10" 
     .Yrange "-10", "-8.0" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ delete port: port1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Port.Delete "1"

'@ define brick: component1:Patch2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch2" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-0.5", "0.5" 
     .Yrange "-8", "-2" 
     .Zrange "0", "0" 
     .Create
End With

'@ delete shape: component1:Patch

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:Patch"

'@ delete shape: component1:Patch2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Delete "component1:Patch2"

'@ define brick: component1:Patch1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-10", "10" 
     .Yrange "-15", "-13" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:solid1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-1", "1" 
     .Yrange "-13", "-7" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ rename block: component1:solid1 to: component1:Patch2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:solid1", "Patch2"

'@ define brick: component1:Patch3

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch3" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-10", "10" 
     .Yrange "-7", "-5" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:Patch4

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch4" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-10", "-8" 
     .Yrange "5", "15" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:Patch5

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch5" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-8", "-1" 
     .Yrange "5", "7" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:Patch6

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch6" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-1", "1" 
     .Yrange "5", "15" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:Patch7

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch7" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "1", "10" 
     .Yrange "13", "15" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:Patch8

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Patch8" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "8", "10" 
     .Yrange "5", "13" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ pick mid point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickMidpointFromId "component1:Subtrate", "1"

'@ align wcs with point

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.AlignWCSWithSelected "Point"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "u", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "u", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "u", "90.0"

'@ rotate wcs

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
WCS.RotateWCS "w", "90.0"

'@ define brick: component1:Line

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Line" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-10", "0" 
     .Yrange "-0.05", "0.05" 
     .Zrange "0", "0.035" 
     .Create
End With


'@ define brick: component1:Path9

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Brick
     .Reset 
     .Name "Path9" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-30", "-10" 
     .Yrange "-5", "5" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ rename block: component1:Patch8 to: component1:Path8

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch8", "Path8"

'@ rename block: component1:Patch7 to: component1:Path7

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch7", "Path7"

'@ rename block: component1:Patch6 to: component1:Path6

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch6", "Path6"

'@ rename block: component1:Patch5 to: component1:Path5

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch5", "Path5"

'@ rename block: component1:Patch4 to: component1:Path4

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch4", "Path4"

'@ rename block: component1:Patch3 to: component1:Path3

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch3", "Path3"

'@ rename block: component1:Patch2 to: component1:Path2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch2", "Path2"

'@ rename block: component1:Patch1 to: component1:Path1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Rename "component1:Patch1", "Path1"

'@ boolean add shapes: component1:Path1, component1:Path2

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path2"

'@ boolean add shapes: component1:Path1, component1:Path3

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path3"

'@ boolean add shapes: component1:Path1, component1:Path4

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path4"

'@ boolean add shapes: component1:Path1, component1:Path5

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path5"

'@ boolean add shapes: component1:Path1, component1:Path6

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path6"

'@ boolean add shapes: component1:Path1, component1:Path7

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path7"

'@ boolean add shapes: component1:Path1, component1:Path8

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path8"

'@ boolean add shapes: component1:Path1, component1:Path9

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Path9"

'@ boolean add shapes: component1:Path1, component1:Line

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solid.Add "component1:Path1", "component1:Line"

'@ pick face

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Pick.PickFaceFromId "component1:Path1", "6"

'@ define port: 1

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "20", "20" 
     .Yrange "-1.19", "1.19" 
     .Zrange "0", "0.035" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "2*2.38", "2*2.38" 
     .ZrangeAdd "0.787", "6*0.787" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With

'@ define monitor: e-field (f=2.4)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=2.4)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "2.4" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define monitor: h-field (f=2.4)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.4)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.4" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define farfield monitor: farfield (f=2.4)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.4)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.4" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ define monitor: e-field (f=7)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=7)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "7" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define monitor: h-field (f=7)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=7)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "7" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With

'@ define farfield monitor: farfield (f=7)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=7)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "7" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.822", "4.757" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With

'@ delete monitors

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Monitor.Delete "e-field (f=2.4)" 
Monitor.Delete "farfield (f=2.4)" 
Monitor.Delete "h-field (f=2.4)" 

'@ define frequency range

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.FrequencyRange "2", "10" 


'@ define monitor: loss (f=6)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Reset 
     .Name "loss (f=6)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "7" 
     .Create 
End With 


'@ define monitor: loss (f=7)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "loss (f=6)" 
End With 
With Monitor 
     .Reset 
     .Name "loss (f=7)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "7" 
     .Create 
End With 


'@ define frequency range

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
Solver.FrequencyRange "3", "8" 


'@ define monitor: h-field (f=6.2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "h-field (f=7)" 
End With 
With Monitor 
     .Reset 
     .Name "h-field (f=6.2)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "6.2" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.82200000000000006", "4.7570000000000006" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With 


'@ define monitor: e-field (f=6.2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "e-field (f=7)" 
End With 
With Monitor 
     .Reset 
     .Name "e-field (f=6.2)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "6.2" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.82200000000000006", "4.7570000000000006" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With 


'@ define farfield monitor: farfield (f=6.2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "farfield (f=7)" 
End With 
With Monitor 
     .Reset 
     .Name "farfield (f=6.2)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "6.2" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.82200000000000006", "4.7570000000000006" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


'@ define monitor: loss (f=6.2)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "loss (f=7)" 
End With 
With Monitor 
     .Reset 
     .Name "loss (f=6.2)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "6.2" 
     .Create 
End With 


'@ define monitor: h-field (f=3.5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "h-field (f=5)" 
End With 
With Monitor 
     .Reset 
     .Name "h-field (f=3.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "3.5" 
     .UseSubvolume "False" 
     .Coordinates "Free" 
     .SetSubvolume "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With 


'@ define monitor: loss (f=3.5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "loss (f=5)" 
End With 
With Monitor 
     .Reset 
     .Name "loss (f=3.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "3.5" 
     .Create 
End With 


'@ define monitor: e-field (f=3.5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "e-field (f=5)" 
End With 
With Monitor 
     .Reset 
     .Name "e-field (f=3.5)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "3.5" 
     .UseSubvolume "False" 
     .Coordinates "Free" 
     .SetSubvolume "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .Create 
End With 


'@ define farfield monitor: farfield (f=3.5)

'[VERSION]2018.0|27.0.2|20171026[/VERSION]
With Monitor 
     .Delete "farfield (f=5)" 
End With 
With Monitor 
     .Reset 
     .Name "farfield (f=3.5)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "3.5" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-20", "20", "-20", "20", "-0.82200000000000006", "4.7570000000000006" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


