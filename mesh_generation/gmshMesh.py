import gmsh

# Using depth to simulate a 3D domain according to OpenFOAM specifications
back = 0
front = 0.1

# Circle properties according to (x-cx)^2 + (y-cy)^2 = r^2  
cx = 0.25
cy = 0.1
r = 0.05

# Rectangle properties according to (minX, maxX) X (minY, max Y)
minX = 0
maxX = 1
minY = 0
maxY = 0.2

# Meshsize
ms1 = 0.01
ms2 = 0.005

gmsh.initialize()
gmsh.clear()

gmsh.model.add("von Karman vortex mesh")

# Set an alias to the geometry
geometry = gmsh.model.occ

# Creation of channel
geometry.addBox(minX, minY, back, maxX, maxY, front, 1)

# Creation of obstacle
geometry.addCylinder(cx, cy, back, 0, 0, front, r, 2)

# Adding the hole
geometry.cut([(3, 1)], [(3, 2)], 3)

# Synchronizing cut
geometry.synchronize()

# Set Physical Groups
gmsh.model.addPhysicalGroup(2, [1], 2001, name = "Inlet")
gmsh.model.addPhysicalGroup(2, [6], 2002, name = "Outlet")
gmsh.model.addPhysicalGroup(2, [2, 4], 2003, name = "Wall")
gmsh.model.addPhysicalGroup(2, [7], 2004, name = "Hole")
gmsh.model.addPhysicalGroup(2, [3, 5], 2005, name = "BackAndFront")
gmsh.model.addPhysicalGroup(3, [3], 3001, name = "Fluid")

# Synchronizing physical groups
geometry.synchronize()

gmsh.model.mesh.generate(dim = 3)
gmsh.model.mesh.refine()

# surface_tags = gmsh.model.getEntities(dim=2)
# for tag in surface_tags:
#     if tag[1] == 1:  # Refine surface with tag 1 (for example)
#         gmsh.model.mesh.refine([(tag[0], tag[1])], algorithm=0)

gmsh.write("mesh_generation/gmshMesh.msh")

gmsh.finalize()