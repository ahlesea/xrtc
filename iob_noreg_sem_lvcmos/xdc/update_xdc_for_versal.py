from pathlib import Path
import re
# # # XDC updates
ku60_swap = ["AM29", "AV32", "AW31", "AW29", "AK31", "AK30", "AL29", "AU32", "AW30", "AV29", "AR30", "AJ31", "AJ30", "AN33", "AP30", "AR31", "AE25", "AR25", "AJ24", "AP23", "AP29", "AR23", "AP33", "AP31", "AR32", "D16", "E16", "AV31", "AD25", "AP25", "AH24", "AN23", "AL30", "AR22", "AJ33", "AU21", "AJ25", "AH26", "AG26", "C13", "A15", "AU31", "AE26", "AG24", "AK21", "AM30", "AP24", "AR21", "AH28", "AJ20", "AF20", "AE20", "N14", "AK33", "AV22", "AK25", "AJ26", "AG27", "D13", "A14", "AD26", "AF24", "AK20", "AN27", "AM27", "AN24", "AP21", "AJ28", "AJ21", "AG20", "AE21", "M14", "AR28", "AR26", "AE27", "AL24", "AM24", "AG25", "AT24", "AU22", "AE23", "AK28", "AH22", "AT28", "AR27", "AF27", "AL25", "AM25", "AF25", "AT23", "AT22", "AW23", "AF23", "AK27", "AH23", "AV28", "AT27", "AU25", "AW25", "AP28", "AL28", "AW24", "AV23", "AJ29", "AW21", "AG21", "AE22", "AW28", "AU27", "AU26", "AW26", "AN28", "AL27", "AV24", "AH29", "AV21", "AG22", "AF22", "AP36", "AR36", "D35", "E35", "D36", "E15", "E36", "F15"]
versal_swap = ["BC30", "BG23", "BF38", "BC36", "BD19", "BG18", "BC31", "BF24", "BE37", "BB36", "BA19", "BE19", "BF18", "BF23", "AW39", "BB38", "BD22", "BB23", "AY23", "AV21", "BA20", "AU27", "BE22", "AY39", "BC38", "BG34", "BG35", "BF36", "BC23", "BA23", "AY22", "AU21", "BF19", "AV26", "AU37", "BC25", "BE25", "BG25", "BE35", "BG33", "BE30", "BE36", "BF28", "BC26", "BA27", "BG19", "AT25", "BG13", "AT16", "BF21", "BE21", "BC20", "BC13", "AU36", "BD25", "BE24", "BG24", "BF34", "BF33", "BE29", "BE27", "BB26", "BA28", "BC16", "BB16", "AT26", "BF14", "AR17", "BG20", "BE20", "BD20", "BD13", "AM29", "AR29", "AT29", "BB31", "BD33", "BG26", "BB28", "AV27", "AU25", "AR27", "AM26", "AN29", "AT28", "AU29", "BB30", "BE34", "BF26", "BB29", "AU28", "BE14", "AV25", "AP28", "AN26", "BD30", "BE31", "BD35", "AT38", "BF32", "BG28", "BC15", "BE15", "BG16", "AN19", "BG11", "BE11", "BD29", "BD32", "BD34", "AT37", "BE32", "BF29", "BB15", "BF16", "AN20", "BF11", "BF12", "AY37", "BA37", "AY27", "AW27", "AN28", "BA31", "AM27", "AY31"]
pin_lookup = dict(zip(ku60_swap, versal_swap))

nc_sigs = ["clk_mstr_50_fpga","fst_clkp_fpga", "fst_clkn_fpga", "gen_clkb_fpga", "diff_clka_p", "diff_clkb_p", "diff_clka_n", "diff_clkb_n", "df_0068_n", "df_0068_p", "se_096", "gen_clka_fpga", "df_0150_n", "df_0150_p", "se_084", "df_i_p_22", "df_i_p_23", "df_i_p_24", "df_i_p_25", "df_i_p_26", "df_i_n_47", "df_i_p_48", "df_i_p_49", "df_i_p_50", "df_i_n_22", "df_i_n_23", "df_i_n_24", "df_i_n_25", "df_i_n_26", "df_i_p_47", "df_i_n_48", "df_i_n_49", "df_i_n_50", "df_o_p_21", "df_o_p_23", "df_o_p_25", "df_o_p_26", "df_o_p_40", "df_o_n_21", "df_o_n_23", "df_o_n_25", "df_o_n_26", "df_o_n_40", "df_o_n_54", "df_o_n_55", "df_o_n_56", "df_o_n_59", "df_o_n_60", "df_o_n_61", "df_o_n_64", "df_o_n_69", "df_o_n_71", "df_o_n_73", "df_o_n_77", "df_o_n_80", "df_o_p_54", "df_o_p_55", "df_o_p_56", "df_o_p_59", "df_o_p_60", "df_o_p_61", "df_o_p_64", "df_o_p_69", "df_o_p_71", "df_o_p_73", "df_o_p_77", "df_o_p_80", "df_0143_p"]
nc_sigs += ["df_i_n_1", "df_i_p_1", "df_0143_p", "df_0114_n", "df_0114_p", "clk_mstr_50_fpga_n", "clk_mstr_50_fpga_p"]

fp_in = Path(__file__).parents[0] / 'constraints_lvcmos.xdc'
fp_out = Path(__file__).parents[0] / 'constraints_lvcmos_versal.xdc'

with open(fp_in, 'r') as f:
    lines = f.readlines()

f_out = open(fp_out, 'w')

for line in lines:
    line = line.strip()
    items = line.split(" ")

    skip = 0
    # remove signals that don't connect through jter
    for nc_sig in nc_sigs:
        r = re.compile(r'\b' + nc_sig + r'\b')
        if re.search(r, line):
            skip = 1

    if line.startswith('#') or len(line.strip()) == 0:
        skip = 1

    if len(items) > 3 and not line.startswith('#') and skip==0:
        if items[2] != "LVDS":
            if items[1] == "PACKAGE_PIN":
                items[2] = pin_lookup[items[2]]
            if items[1] == "IOSTANDARD":
                items[2] = "LVCMOS15"

        else:
            items[2] = "LVDS15"

    if skip==0:
        txt = f"{' '.join([i for i in items])}\n"
        print(txt)
        f_out.write(txt)



