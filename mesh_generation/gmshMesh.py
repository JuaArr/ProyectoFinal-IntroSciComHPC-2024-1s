import gmsh

# --------------------------- Constants ---------------------------

# Circle properties: (x-cx)^2 + (y-cy)^2 = r^2  
cx = 25
cy = 10
r = 5

# Parallelepid dimensions: (minX, maxX) X (minY, maxY) X (minZ, maxZ)
minX = 0
maxX = 100
minY = 0
maxY = 20
minZ = 0
maxZ = 10

# Standard mesh size
lc = 1

# --------------------------- Initial Set Up ---------------------------

gmsh.initialize()
gmsh.clear()

# Set aliases
option = gmsh.option
model = gmsh.model
occ = model.occ
mesh = model.mesh

# Add model name
model.add("von Karman vortex mesh")

# --------------------------- Core Geometry ---------------------------

# Creation of channel
occ.addBox(minX, minY, minZ, maxX, maxY, maxZ, 1)

# Creation of obstacle
occ.addCylinder(cx, cy, minZ, 0, 0, maxZ, r, 2)

# Adding the hole
occ.cut([(3, 1)], [(3, 2)], 3)

# Synchronizing cut
occ.synchronize()

# --------------------------- Physical Groups ---------------------------

# Set Physical Groups
model.addPhysicalGroup(2, [1], 2001, name = "Inlet")
model.addPhysicalGroup(2, [6], 2002, name = "Outlet")
model.addPhysicalGroup(2, [2, 4], 2003, name = "Wall")
model.addPhysicalGroup(2, [7], 2004, name = "Hole")
model.addPhysicalGroup(2, [3, 5], 2005, name = "BackAndFront")
model.addPhysicalGroup(3, [3], 3001, name = "Fluid")

# Synchronizing physical groups
occ.synchronize()

# --------------------------- Boundary Layer ---------------------------

# Set up of the mesh size according to the distance to the "Wall" and "Hole"
mesh.field.add("Distance", 1)
mesh.field.setNumbers(1, "SurfacesList", [2, 4, 7])
mesh.field.setNumber(1, "Sampling", 100)

# Set up of the mesh size according to a threshold
mesh.field.add("Threshold", 2)
mesh.field.setNumber(2, "InField", 1)
mesh.field.setNumber(2, "SizeMin", lc/10)
mesh.field.setNumber(2, "SizeMax", lc)
mesh.field.setNumber(2, "DistMin", 0)
mesh.field.setNumber(2, "DistMax", 3)

# Using the threshold mesh size field
mesh.field.setAsBackgroundMesh(2)

# Using a good practice to avoid over-refinement
option.setNumber("Mesh.MeshSizeExtendFromBoundary", 0)
option.setNumber("Mesh.MeshSizeFromPoints", 0)
option.setNumber("Mesh.MeshSizeFromCurvature", 0)

# --------------------------- Structured Mesh ---------------------------

# for curve in occ.getEntities(1):
#     mesh.setTransfiniteCurve(curve[1], 15)

# for surf in occ.getEntities(2):
#     mesh.setTransfiniteSurface(surf[1])

# option.setNumber('Mesh.QuasiTransfinite', 1)

# --------------------------- Mesh Generation ---------------------------

# Mesh algorithm
# option.setNumber('Mesh.RecombineAll', 1)
# option.setNumber('Mesh.RecombinationAlgorithm', 1)
# option.setNumber('Mesh.Recombine3DLevel', 2)
option.setNumber('Mesh.ElementOrder', 1)

# Mesh generation
mesh.generate(dim = 3)

# --------------------------- Save and Close ---------------------------

gmsh.write("mesh_generation/gmshMesh.msh")
gmsh.finalize()