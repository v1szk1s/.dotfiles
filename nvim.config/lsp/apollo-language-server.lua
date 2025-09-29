return {
	-- Command and arguments to start the server.
	cmd = { 'rover', 'lsp', '--supergraph-config', 'supergraph.yaml' },

	-- Filetypes to automatically attach to.
	filetypes = { 'graphql' },

	root_markers = { 'supergraph.yaml' },

}
