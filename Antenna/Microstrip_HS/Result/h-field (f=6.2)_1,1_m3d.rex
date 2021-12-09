<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile creator="Solver HFTD - Field 3DFD Monitor" version="20170330">
  <SpecialMaterials>
    <Background type="NORMAL"/>
    <Material name="Copper (annealed)" type="FIELDFREE"/>
  </SpecialMaterials>
  <SimulationProperties dB_Amplitude="20" encoded_unit="&amp;U:A^1.:m^-1" fieldname="&lt;name missing&gt;" fieldtype="H-Field" frequency="6.1999998092651367188" label=""/>
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <ResultGroups num_steps="1">
    <Frame index="0" tfo="h-field (f=6.2)_1,1_m3d.tfo">
      <FieldResultFile filename="h-field (f=6.2)_1,1.m3d" type="m3d"/>
    </Frame>
  </ResultGroups>
  <ResultDataType complex="1" timedomain="0" vector="1"/>
  <Symmetries>
    <SymmetryY type="inverted mirror inverted" offset="0 0 0"/>
  </Symmetries>
  <SimulationDomain min="-33.62693023682 -33.62693023682 -14.44892978668" max="33.62693023682 33.62693023682 18.3839302063"/>
  <PlotSettings Clipping="Possible" Plot="4" ignore_symmetry="0" deformation="0"/>
  <Source type="SOLVER"/>
</MetaResultFile>
