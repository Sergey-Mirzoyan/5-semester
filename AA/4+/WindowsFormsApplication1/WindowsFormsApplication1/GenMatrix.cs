using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class GenMatrix
    {
        private double[,] _matr1, _matr2, res;
        System.Threading.Thread[] _threadArray;
        private int _size;
        DateTime t1, t2;

        public GenMatrix(int matr_size)
        {
            Generate(matr_size);
        }

        public int Multiply(int thr_count)
        {
            t1 = DateTime.Now;
            CreateThreads(thr_count);
            t2 = DateTime.Now;
            TimeSpan result = t2 - t1;
            return result.Minutes * 60 + result.Seconds * 1000 + result.Milliseconds;
        }

        public int Multiply()
        {
            t1 = DateTime.Now;
            MultiplyMatr(new int[] { 0, _size });
            t2 = DateTime.Now;
            TimeSpan result = t2 - t1;
            return result.Minutes * 60 + result.Seconds * 1000 + result.Milliseconds;
        }

        private void CreateThreads(int count)
        {
            _threadArray = new Thread[count];
            for (int i = 0; i < count; ++i)
            {
                _threadArray[i] = new Thread(this.MultiplyMatr);
            }
            int s = _size / count;

            for (int i = 0; i < count - 1; ++i)
            {
                _threadArray[i].Start(new int[] { i * s, s });
            }
            _threadArray[count - 1].Start(new int[] { (count - 1) * s, _size - (count - 1) * s });

            for (int i = 0; i < count; ++i)
            {
                _threadArray[i].Join();
            }
        }

        private double[,] FillMatr(int n, int m)
        {
            var res = new double[n, m];
            var rand = new Random();

            for (var i = 0; i < n; ++i)
            {
                for (var j = 0; j < m; ++j)
                {
                    res[i, j] = rand.Next(100) * rand.NextDouble();
                }
            }

            return res;
        }

        private void Generate(int size)
        {
            _size = size;
            _matr1 = FillMatr(size, size);
            _matr2 = FillMatr(size, size);
            res = new double[size, size];
        }


        private void MultiplyMatr(Object obj)
        {
            var pars = obj as int[];
            int n = _matr1.GetLength(0),
                q = _matr2.GetLength(1),
                m = _matr2.GetLength(0);
            for (var i = pars[0]; i < pars[0] + pars[1]; ++i)
            {
                for (var j = 0; j < q; ++j)
                {
                    for (var k = 0; k < m; ++k)
                    {
                        res[i, j] += _matr1[i, k] * _matr2[k, j];
                    }
                }
            }
        }
    }
}