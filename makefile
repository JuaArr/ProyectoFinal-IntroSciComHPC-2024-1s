gmsh_mesh_dir = mesh_generation
py = python3

all: generate_mesh

generate_mesh: $(gmsh_mesh_dir)/gmshMesh.py
#	$(py) $^ 1> $(gmsh_mesh_dir)/gmshSummary.txt 2> $(gmsh_mesh_dir)/gmshEW.txt
	$(py) $^