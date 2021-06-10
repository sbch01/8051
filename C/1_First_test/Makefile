#AT89S52
#sdcc  -mmcs51 --iram-size 256 --xram-size 0 --code-size 8192  --nooverlay --noinduction 
#--verbose --debug -V --std-sdcc89 --model-large

all: generate clean

generate:
	sdcc  -mmcs51 --iram-size 256 --xram-size 0 --code-size 8192  --nooverlay --noinduction  --verbose --debug -V --std-sdcc99  main.c -o main

#Изчиства всички файлове - асемблер и hex 	
clean:
	@echo "Cleaning file..."
	@rm *.lk *.lst *.map *.mem *.rel *.rst  *.sym *.adb *.cdb *.omf

#Изчиства всички файлове + асемблер и hex 	
clear:
	@echo "Cleaning file..."
	@rm *.lk *.lst *.map *.mem *.rel *.rst  *.sym *.adb *.cdb *.omf main *.asm