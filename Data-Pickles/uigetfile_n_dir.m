function [pathname] = uigetfile_n_dir(start_path, dialog_title)
% Pick multiple directories and/or files

import javax.swing.JFileChooser;

% if nargin == 0 || start_path == '' || start_path == 0 % Allow a null argument.
%     start_path = pwd;
% end

jchooser = javaObjectEDT('javax.swing.JFileChooser', start_path);

jchooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
if nargin > 1
    jchooser.setDialogTitle(dialog_title);
end

jchooser.setMultiSelectionEnabled(true);

status = jchooser.showOpenDialog([]);

if status == JFileChooser.APPROVE_OPTION
    jFile = jchooser.getSelectedFiles();
	pathname{size(jFile, 1)}=[];
    for n=1:size(jFile, 1)
		pathname{n} = char(jFile(n).getAbsolutePath);
	end
	
elseif status == JFileChooser.CANCEL_OPTION
    pathname = [];
else
    error('Error occured while picking file.');
end

end
