from pathlib import Path
import re

nc_sigs = ["fst_clkp_fpga", "fst_clkn_fpga", "gen_clkb_fpga", "diff_clka_p", "diff_clkb_p", "diff_clka_n", "diff_clkb_n", "df_0068_n", "df_0068_p", "se_096", "gen_clka_fpga", "df_0150_n", "df_0150_p", "se_084", "df_i_p_22", "df_i_p_23", "df_i_p_24", "df_i_p_25", "df_i_p_26", "df_i_n_47", "df_i_p_48", "df_i_p_49", "df_i_p_50", "df_i_n_22", "df_i_n_23", "df_i_n_24", "df_i_n_25", "df_i_n_26", "df_i_p_47", "df_i_n_48", "df_i_n_49", "df_i_n_50", "df_o_p_21", "df_o_p_23", "df_o_p_25", "df_o_p_26", "df_o_p_40", "df_o_n_21", "df_o_n_23", "df_o_n_25", "df_o_n_26", "df_o_n_40", "df_o_n_54", "df_o_n_55", "df_o_n_56", "df_o_n_59", "df_o_n_60", "df_o_n_61", "df_o_n_64", "df_o_n_69", "df_o_n_71", "df_o_n_73", "df_o_n_77", "df_o_n_80", "df_o_p_54", "df_o_p_55", "df_o_p_56", "df_o_p_59", "df_o_p_60", "df_o_p_61", "df_o_p_64", "df_o_p_69", "df_o_p_71", "df_o_p_73", "df_o_p_77", "df_o_p_80", ]
nc_sigs += ["df_i_n_1", "df_i_p_1", "df_0143_p", "df_0114_n", "df_0114_p", "clk_mstr_50_fpga_n", "clk_mstr_50_fpga_p"]
fp_out = Path(__file__).parents[0] / "iob_lvcmos_dut_reg_versal.vhd" 
fp = Path(__file__).parents[0] / "iob_lvcmos_dut_reg.vhd"
fp.exists()

with open(fp, 'r', encoding='utf-8') as f:
    lines = f.readlines()

f_out = open(fp_out, 'w')

for ll, line in enumerate(lines):
    found = 0
    if ll==663:
        print(ll)

    for sig in nc_sigs:
        search = re.compile(r'\b' + sig + r'\b')
        if re.search(search,  line):
            found = 1
            break
    if found == 0:
        f_out.write(line)

f_out.close()



