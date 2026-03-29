return {
  {
    "idossha/matlab.nvim",
    ft = "matlab",
    config = function()
      require("matlab").setup({
        auto_start = false,
      })
    end,
    keys = {
      {
        "<leader>ms",
        function()
          vim.cmd("MatlabStartServer")
        end,
        mode = "n",
        desc = "MATLAB: Start server",
      },
      {
        "<leader>mq",
        function()
          vim.cmd("MatlabStopServer")
        end,
        mode = "n",
        desc = "MATLAB: Stop server",
      },
    },
  },
}
