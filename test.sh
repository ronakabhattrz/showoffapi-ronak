for i in {1..500}
do
printf "\n------------------\n"
echo "Welcome $i times"
printf "\n"
curl -i -H "Authorization: Token token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODU4NDAxNjV9.13AyreE54pBu5E-V4YcZrLO5Y0JFTmXQA4R7Zup1Cvs" http://localhost:3000/api/v1/widgets/3

done