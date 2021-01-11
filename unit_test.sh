alias into="docker exec -it ora_profile_unit_test bash"
alias stop="docker kill ora_profile_unit_test"
docker run -it --rm -d --name ora_profile_unit_test \
  -h ora_profile_unit_test \
  -v $PWD:/sut \
  ruby:2.5.4 bash
docker attach ora_profile_unit_test