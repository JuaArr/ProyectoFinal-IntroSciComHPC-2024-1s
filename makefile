gmsh_mesh_dir = mesh_generation
py = python3

.PHONY: cleanMeshOutput

all: generateMesh

generateMesh: $(gmsh_mesh_dir)/gmshMesh.py
	$(py) $^ 1> $(gmsh_mesh_dir)/gmshSummary.txt 2> $(gmsh_mesh_dir)/gmshError.txt

cleanMeshOutput:
	rm -f $(gmsh_mesh_dir)/*.msh $(gmsh_mesh_dir)/*.txt