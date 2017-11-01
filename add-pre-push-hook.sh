if [ ! -d "$../.git/hooks/pre-push" ]; then
cp ../pre-push ../.git/hooks/pre-push
exit 0
fi