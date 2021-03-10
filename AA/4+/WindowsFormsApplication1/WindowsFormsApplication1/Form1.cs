using System;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
using ConsoleApplication1;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {

        private void TimeAnalysys(DataPointCollection pnts1, DataPointCollection pnts2, DataPointCollection pnts3,
            DataPointCollection pnts4, DataPointCollection pnts6)
        {
            for (var n = 100; n <= 1000; n += 100)
            {
                var matrixes = new GenMatrix(n);
                int time;

                time = matrixes.Multiply();
                pnts6.AddXY(n, time);

                time = matrixes.Multiply(1);
                pnts1.AddXY(n, time);

                time = matrixes.Multiply(2);
                pnts2.AddXY(n, time);

                time = matrixes.Multiply(4);
                pnts3.AddXY(n, time);

                time = matrixes.Multiply(10);
                pnts4.AddXY(n, time);;
            }
        }

        public Form1()
        {
            InitializeComponent();

        }

        private void Form1_Shown(object sender, EventArgs e)
        {
            TimeAnalysys(chart1.Series["Series1"].Points, chart1.Series["Series2"].Points, chart1.Series["Series3"].Points, chart1.Series["Series4"].Points, chart1.Series["Series6"].Points);
        }
    }
}
