#!/opt/local/bin/gnuplot

FN_IN = "data"
FN_OUT = "trackmaven-bar-chart.pdf"

set print "-"
#print sprintf("FN_OUT=%s", FN_OUT)

abbr_company = 1

if (abbr_company) {
	set terminal pdfcairo enhanced font "Verdana" size 2.9in, (2.5*0.75)in
} else {
	set terminal pdfcairo enhanced font "Verdana" size 2.7in, (2.5*0.95)in
}

set output FN_OUT

set ylabel "Metric" offset 1.5,0

set border front lc rgb "#808080" back
set grid ytics mytics back lc rgb "black"

if (abbr_company) {
	set xtics scale 0,0 nomirror tc rgb "black"
} else {
	set xtics scale 0,0 nomirror tc rgb "#505050" right rotate by 90
}

set ytics scale 0,0 nomirror tc rgb "black" autofreq 0,20
set mytics 2
set tics front

set bmargin screen 0.2

# Box width
BW = 0.33

# Gap between boxes
BG = 0.05

# Box transparency
BTP = 0.4

# Add small gap (1) for every 3 columns
# + 0.0000001 to fix the error of the first one. I think it's from the floating point rounding error.
x(a)=a + floor((a + BW + BG/2.0 + 0.0000001)/3)

# Bottom label
if (1) {
	if (1) {
		x0 = 1
		y0 = 0.05
		set label "PS" at x(x0), screen y0 center
		x0 = x0 + 3
		set label "SB" at x(x0), screen y0 center
		x0 = x0 + 3
		set label "DL" at x(x0), screen y0 center
		x0 = x0 + 3
		set label "LI" at x(x0), screen y0 center
	} else {
		x0 = 1
		y0 = 0.20
		y1 = 0.10
		set label "PREFERRED\nSANDS"      at x(x0), screen y1 center
		x0 = x0 + 3
		set label "SIGNALS\n& BON TON"    at x(x0), screen y0 center
		x0 = x0 + 3
		set label "DRILLMEX\n& LANCASTER" at x(x0), screen y1 center
		x0 = x0 + 3
		set label "LIBERTY"               at x(x0), screen y0 center
	}
}

set label "Channel" at screen 0.73, screen 0.87 left
set key             at screen 0.73, screen 0.81 left

set xrange[-1:15]
set yrange[0:]

plot \
FN_IN u (x($0)):3:(x($0-BG/2.0-BW)):(x($0-BG/2.0   )):(0):3:xticlabel(substr(strcol(2), 1, 1)) w boxxyerrorbars fs transparent solid BTP lc rgb "red"  t "A", \
FN_IN u (x($0)):4:(x($0+BG/2.0   )):(x($0+BG/2.0+BW)):(0):4 w boxxyerrorbars fs transparent solid BTP lc rgb "blue" t "B", \

# boxxyerrorbars parameters
#   x  y  xlow  xhigh  ylow  yhigh
