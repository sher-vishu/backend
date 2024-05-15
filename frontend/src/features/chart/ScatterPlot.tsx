import React from 'react';
import { Scatter } from 'react-chartjs-2';
import { DataPoint } from '../../types/types';
import {
  Chart as ChartJS,
  ArcElement,
  CategoryScale,
  LinearScale,
  Title,
  Tooltip,
  Legend,
  PointElement
} from 'chart.js';
ChartJS.register(
  ArcElement,
  CategoryScale,
  LinearScale,
  Title,
  Tooltip,
  Legend,
  PointElement
);


interface UmapScatterChartProps {
  data: DataPoint[];
}

const getColorForLabel = (label: number): string => {
  switch (label) {
    case 0: return 'violet';
    case 1: return 'indigo';
    case 2: return 'blue';
    case 3: return 'green';
    case 4: return 'yellow';
    case 5: return 'orange';
    case 6: return 'red';
    case 7: return 'brown';
    default: return 'black'; // default color if label is out of range
  }
};

const UmapScatterChart: React.FC<UmapScatterChartProps> = ({ data }) => {

            const chartData = {
              datasets: data.map(dataPoint => ({
                label: `Label ${dataPoint.labels}`,
                data: [{ x: dataPoint.x, y: dataPoint.y }],
                backgroundColor: getColorForLabel(dataPoint.labels),
                borderColor: getColorForLabel(dataPoint.labels),
                pointRadius: 1,
                pointHoverRadius: 4
              }))
            };

  const options = {
    scales: {
      x: {
        type: 'linear',
        position: 'bottom',
        title: {
          display: true,
          text: 'UMAP 1'
        }
      },
      y: {
        type: 'linear',
        position: 'left',
        title: {
          display: true,
          text: 'UMAP 2'
        }
      }
    },
    plugins: {
      legend: {
        display: false 
      },
      tooltip: {
        callbacks: {
          label: (context: any) => {
            const dataPointIndex = context.dataIndex;
            const dataPoint = data[dataPointIndex];
            console.log(dataPointIndex)
            return `Barcode: ${dataPoint.barcode}`;
          }
        }
      }
    }
  }as const;

  return (
    <div>
        <Scatter data={chartData} options={options}/>
    </div>
  );
};

export default UmapScatterChart;
