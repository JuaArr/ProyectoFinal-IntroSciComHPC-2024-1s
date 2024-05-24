gmsh_mesh_dir = mesh_generation
py = python3

all: generate_mesh

generate_mesh: $(gmsh_mesh_dir)/gmshMesh.py
	$(py) $^