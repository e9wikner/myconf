function gr
	git rebase $argv
end
function gri
	git rebase -i $argv
end
function grc
	git rebase --continue
end
function gra
	git rebase --abort
end
