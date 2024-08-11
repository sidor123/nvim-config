return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local status_ok, alpha = pcall(require, "alpha")
		if not status_ok then
			return
		end

		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠟⠉⠁⠈⠂⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣥⣤⣶⣶⣦⣠⣃⣤⣤⣤⣤⣤⡶⠶⣖⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣬⣽⣷⣴⠖⠆]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⢄⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣯⡶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀⢠⣴⣼⣤⣼⣧⣿⣿⣿⡏]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣟⢿⣿⣿⣿⣿⠻⠿⠯⠤⠤⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠀⠀⠀⠀⢈⣿⣿⣿⣿⣿⣿⣿⡛⠃]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣟⣿⣯⣹⣿⣋⠙⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠈⡉⠻⣿⢿⣿⣿⣧⡀]],
			[[⠀⠀⠀⠀⠀⠀⢠⠼⠁⠰⠟⡟⣄⣾⣿⠟⢺⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⡀⠀⠀⠀⠀⠀⠀⠀⠐⠚⠳⣾⣿⣿⣿⣿⣦⡀]],
			[[⠀⠀⠀⠀⠀⠀⣾⡇⡆⠀⠸⡟⠸⡠⢹⠀⢿⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣆]],
			[[⠀⠀⠀⠀⠀⢰⢿⠧⢷⢴⣠⡄⡈⣗⡿⣳⣮⡿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣧]],
			[[⠀⠀⠀⠀⠀⠰⡿⣷⠿⠈⣻⣿⡿⣷⠟⣽⡟⣉⠙⣢⣄⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⣤⠄⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆]],
			[[⠀⠀⠀⠀⠀⠀⢵⣿⣲⠧⠯⠿⢿⣿⢞⣿⣿⡙⢻⡿⠿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢗⠳⣤⣠⣴⣂⠀⣀⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
			[[⠀⠀⠀⠀⠀⠀⡿⣙⡮⠛⠀⠠⣩⣟⣵⣮⣻⢁⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣯⣅⢀⢀⡨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧]],
			[[⠀⠀⠀⠀⠀⠀⠘⢿⣿⣷⣶⣶⣿⣦⣹⠻⣃⠻⣆⣀⣀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠿⣫⣶⣦⠴⠚⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀]],
			[[⠀⠀⠀⠀⠀⠀⠀⣽⣻⣟⣯⢷⢽⣷⣿⣶⣜⡷⠷⢿⣪⣼⡦⢀⣀⡀⠀⠀⢠⣴⣶⣶⣶⣶⣶⠦⠤⢤⣄⠀⠀⠀⠀⠀⠀⣾⡟⠀⠀⠀⠀⠀⠈⠉⠀⠈⠙⣛⣩⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇]],
			[[⠀⠑⡲⡤⠼⠀⠀⢿⡷⡤⠼⣻⣶⡿⣟⡿⠿⣿⣿⣋⣿⣷⣿⣮⣻⡿⣿⣿⡿⣯⡽⡿⠉⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠛⣿⣶⣶⣤⣤⣄⠀⢀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠁]],
			[[⠒⢶⡏⡀⠀⠀⠀⡼⣿⢿⣡⠿⣣⣾⣿⣿⣯⣭⣭⣿⣶⣾⡿⠛⠋⢿⣿⣿⣿⡟⠏⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣀]],
			[[⠀⠈⡷⢾⣧⢴⣿⣿⡷⠟⣡⣈⢹⣿⣿⣿⣿⡿⠟⠋⡽⠛⣥⣴⡿⠿⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡋⠀⠈⠁⠀⣀⡴⠀⠀⢶⡆]],
			[[⣓⣾⣀⣀⡨⠟⠛⢿⣶⣿⣿⣬⣾⡿⠋⠭⠐⠂⢀⠀⣵⣬⠥⠀⠀⠀⠀⠀⠀⠠⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠛⠛⠻⠋⢉⠛⠛⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡤⠖⡻⡿⠒⡡⢜⣉⠄]],
			[[⣯⣽⣻⣿⣥⣭⣭⣾⣿⣽⣿⣿⡞⠙⣃⠀⠉⠀⣾⣫⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣄⡀⠀⠐⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⢤⠴⢷⣿⣿⣙⣿⣿⡃⣢⣤⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠠⠐⢒⣿⣻⣾⡇]],
			[[⡿⡿⢯⡁⠀⡏⠋⢡⣎⡙⠒⠺⢿⡟⠿⠧⣤⣤⢾⣯⣏⣀⠠⢠⣀⡐⠒⠦⠀⠀⠰⢦⣤⣀⣀⠀⣀⠀⠀⠀⠒⠀⠠⣴⣗⣀⡀⠀⠐⣛⣛⡿⢿⣻⣡⣿⣿⣷⣾⣿⣯⠬⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣉⣜⣋⠅]],
			[[⠛⢦⣽⣷⡦⠀⣠⣻⣝⣷⣿⣯⡙⢷⣿⣶⣿⣿⣷⣿⣦⣤⣤⣽⣿⣿⣯⣉⣒⣦⣴⣿⣋⠉⡈⠈⢉⢀⣉⣀⣨⣶⣾⣿⣯⣥⣶⣶⣾⣿⣁⣼⢶⢿⣻⣷⣿⣿⣿⣷⣯⢄⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣉⣿⣿⣿⣿⡆]],
			[[ ⣵⣾⣽⠻⣵⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣷⣿⣿⣿⣿⣿⣯⣭⣛⣿⣿⣿⣿⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣿⣿⡯⣺⣿⣿⣿⣿⣿⣿⣿⣿⡍⣙⣿⣽⣿⣿⣿⣿⢾⡿⣿⣿⣿⣿⣭⣼⣿⣷⡇]],
			[[ ⠒⢶⣽⣿⣶⣯⣿⣿⣽⣿⣿⣟⡲⠶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣏⣅⣋⣿⡿⠿⣿⣿⣤⣽⣯⣴⣾⣿⢟⣿⣷⡿⢯⣼⣟⠋ ]],
			[[  ⠀⠈⠛⠓⠓⠛⠛⠉⠁⠛⠛⠛⠚⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠓⠐⠚⠛⠛⠒⠚⠛⠛⠓⠛⠛⠛⠛⠙⠉    ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  Begin adventure (New file)", ":ene <BAR> startinsert <CR>"),
			dashboard.button("SPC e", "  Open Bushido (Neo-tree)", ":Neotree toggle <CR>"),
			dashboard.button("SPC s f", "󰓥  Look for troubles (Find file)", ":Telescope find_files <CR>"),
			dashboard.button("SPC c", "  Die with honor (Close neovim)", ":qa<CR>"),
		}

		local phrases = {
			"1. Accept everything just the way it is.",
			"2. Do not seek pleasure for its own sake.",
			"3. Do not, under any circumstances, depend on a partial feeling.",
			"4. Think lightly of yourself and deeply of the world.",
			"5. Be detached from desire your whole life long.",
			"6. Do not regret what you have done.",
			"7. Never be jealous.",
			"8. Never let yourself be saddened by a separation.",
			"9. Resentment and complaint are appropriate neither for oneself nor others.",
			"10. Do not let yourself be guided by the feeling of lust or love.",
			"11. In all things have no preferences.",
			"12. Be indifferent to where you live.",
			"13. Do not pursue the taste of good food.",
			"14. Do not hold on to possessions you no longer need.",
			"15. Do not act following customary beliefs.",
			"16. Do not collect weapons or practice with weapons beyond what is useful.",
			"17. Do not fear death.",
			"18. Do not seek to possess either goods or fiefs for your old age.",
			"19. Respect Buddha and the gods without counting on their help.",
			"20. You may abandon your own body but you must preserve your honor.",
			"21. Never stray from the Way.",
		}

		local function footer()
			math.randomseed(os.time())
			local phrase = phrases[math.random(#phrases)]
			return phrase
		end

		dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
