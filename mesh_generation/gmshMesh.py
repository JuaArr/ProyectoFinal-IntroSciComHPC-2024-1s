import gmsh

# Using depth to simulate a 3D domain according to OpenFOAM specifications
d = -0.5
h = 1

# Circle properties according to (x-cx)^2 + (y-cy)^2 = r^2  
cx = 0
cy = 0
r = 0.75

# Rectangle properties according to (minX, maxX) X (minY, max Y)
minX = -0.25
maxX = 0.65
minY = -0.10
maxY = 0.10

# Meshsize
ms1 = 0.05
ms2 = 0.01

gmsh.initialize()

gmsh.model.add("von Karman vortex mesh")

gmsh.model.geo.addPoint(cx, cy, d, ms2, 1)
gmsh.model.geo.addPoint(cx+r, cy, d, ms2, 2)
gmsh.model.geo.addPoint(cx-r, cy, d, ms2, 3)
gmsh.model.geo.addCircleArc(2, 1, 3, 1)
gmsh.model.geo.addCircleArc(3, 1, 2, 2)

gmsh.model.geo.addCurveLoop([1, 2], 3)
gmsh.model.geo.addPlaneSurface([3], 1)

gmsh.model.geo.synchronize()

gmsh.model.mesh.generate(2)

gmsh.write("mesh_generation/gmshMesh.msh")

gmsh.finalize()