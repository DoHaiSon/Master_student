<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile creator="Solver HFTD - Field 3DFD Monitor" version="20170330">
  <SpecialMaterials>
    <Background type="FIELDFREE"/>
    <Material name="air_0" type="FIELDFREE_HIDESURFACE"/>
  </SpecialMaterials>
  <SimulationProperties dB_Amplitude="10" encoded_unit="&amp;U:W^1.:m^-3" fieldname="&lt;name missing&gt;" fieldtype="Power Loss Density" frequency="3.5" label=""/>
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <ResultGroups num_steps="1">
    <Frame index="0" tfo="loss (f=3.5)_1,1_m3d.tfo">
      <FieldResultFile filename="loss (f=3.5)_1,1.m3d" type="m3d"/>
    </Frame>
  </ResultGroups>
  <ResultDataType complex="0" timedomain="0" vector="0"/>
  <Symmetries>
    <SymmetryY type="mirror" offset="0"/>
  </Symmetries>
  <SimulationDomain min="-33.62693023682 -33.62693023682 -14.44892978668" max="33.62693023682 33.62693023682 18.3839302063"/>
  <PlotSettings Clipping="Possible" Plot="4" ignore_symmetry="0" deformation="0"/>
  <Source type="SOLVER"/>
</MetaResultFile>
