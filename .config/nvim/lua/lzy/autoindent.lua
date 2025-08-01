vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		-- Save cursor position and view state
		local saved_cursor = vim.fn.getpos(".")
		local saved_view = vim.fn.winsaveview()

		-- Format using conform.nvim
		local success, result = pcall(require("conform").format, {
			timeout_ms = 500,
			lsp_fallback = true, -- Use LSP as fallback
			async = false, -- Ensure synchronous execution
			quiet = true, -- Suppress notifications
		})

		-- Fallback to built-in formatting only if conform fails
		if not success or not result then
			-- Use lockmarks to preserve marks and jumplist
			vim.cmd("lockmarks normal! gg=G")
		end

		-- Restore cursor position and view
		vim.fn.setpos(".", saved_cursor)
		vim.fn.winrestview(saved_view)
	end,
})
