#AT89S52
#sdcc  -mmcs51 --iram-size 256 --xram-size 0 --code-size 8192  --nooverlay --noinduction 
#--verbose --debug -V --std-sdcc89 --model-large

all: generate #clean

generate:
	sdcc -mmcs51 --iram-size 256 --code-size 8192 --debug --std-sdcc99 main.c -o main
	
clean:
	@echo "Cleaning file..."
	@rm *.lk *.lst *.map *.mem *.rel *.rst  *.sym *.adb *.cdb *.omf main
	
