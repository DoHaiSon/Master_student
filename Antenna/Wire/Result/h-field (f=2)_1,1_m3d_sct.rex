<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile creator="Solver HFTD - Field 3DFD Monitor" version="20170330">
  <SpecialMaterials>
    <Background type="NORMAL"/>
    <Material name="Copper (annealed)" type="FIELDFREE"/>
    <Material name="PEC" type="FIELDFREE"/>
  </SpecialMaterials>
  <SimulationProperties dB_Amplitude="20" encoded_unit="&amp;U:A^1.:m^-1" fieldname="&lt;name missing&gt;" fieldtype="H-Field" frequency="2" label=""/>
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <ResultGroups num_steps="1">
    <Frame index="0" tfo="h-field (f=2)_1,1_m3d_sct.tfo">
      <FieldResultFile filename="h-field (f=2)_1,1.m3d" type="m3d"/>
    </Frame>
  </ResultGroups>
  <ResultDataType complex="1" timedomain="0" vector="1"/>
  <SimulationDomain min="-37.62183761597 -37.62183761597 -62.82625579834" max="37.62183761597 37.62183761597 62.4740562439"/>
  <PlotSettings Clipping="Possible" Plot="2" ignore_symmetry="0" deformation="0"/>
  <Source type="SOLVER"/>
</MetaResultFile>
