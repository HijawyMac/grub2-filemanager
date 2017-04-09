# Grub2-FileManager
# Copyright (C) 2016,2017  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.

set pager=1;
if regexp 'pc' "$grub_platform"; then
	modlist="915resolution all_video bitmap bitmap_scale blocklist cat cmp cpuid crc datetime dd disk drivemap elf file getkey gfxmenu gfxterm gfxterm_background gfxterm_menu gptsync hashsum hexdump hwmatch jpeg loadenv lsapm macho memdisk multiboot multiboot2 net offsetio parttool png procfs random search_fs_uuid search_label sendkey squash4 syslinuxcfg terminfo tga time trig true vbe vga video video_bochs video_cirrus video_colors video_fb videoinfo xnu";
else
	modlist="all_video video_bochs video_cirrus efi_gop efi_uga gfxterm gfxterm_background gfxmenu jpeg png tga font";
	search -s -f -q /efi/microsoft/boot/bootmgfw.efi;
	if regexp 'efi32' "$grub_firmware"; then
		search -s -f -q /efi/boot/bootia32.efi;
	else
		search -s -f -q /efi/boot/bootx64.efi;
	fi
fi
for module in $modlist; do
	insmod $module;
done;

loadfont ${prefix}/fonts/unicode.pf2.xz

set locale_dir=${prefix}/locale; export locale_dir

set lang=zh_CN; export lang

set gfxmode=1024x768; export gfxmode
set gfxpayload=keep; export gfxpayload
terminal_output gfxterm

set color_normal=white/black
set color_highlight=black/white

set theme=${prefix}/themes/slack/theme.txt; export theme

set encoding="utf8"; export encoding;

configfile $prefix/main.sh;
