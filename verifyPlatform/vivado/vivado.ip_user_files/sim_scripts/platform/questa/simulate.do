onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib platform_opt

do {wave.do}

view wave
view structure
view signals

do {platform.udo}

run -all

quit -force
