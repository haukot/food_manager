REBAR = ./rebar

all: dependencies compile_all

dependencies:
	$(REBAR) get-deps
compile_all:
	$(REBAR) compile  
compile:
	$(REBAR) skip_deps=true compile  
tests: 
	$(REBAR) -C rebar.config get-deps compile
	ERL_FLAGS="-config app.config -pa ebin deps/*/ebin" $(REBAR) -C rebar.config skip_deps=true eunit 
clean:
	$(REBAR) clean 
start:
	erl -pa ebin deps/*/ebin +pc unicode -s food_mng
rserve:
	R -f r_src/init.r --gui-none --no-save
deploy:
	git push rhc
ssh:
	ssh 528bad4e4382ec462e000021@food-haukot.rhcloud.com
heroku:
	git push heroku master
logs:
	heroku logs -t
