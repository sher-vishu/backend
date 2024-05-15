import React, { useEffect, useState } from 'react';
import Papa from 'papaparse';
import UmapScatterChart from './ScatterPlot'; 
import { DataPoint } from '../../types/types';

const CsvParser: React.FC = () => {
  const [chartData, setChartData] = useState<DataPoint[]>([]);
  const [downsampledData, setDownsampledData] = useState<DataPoint[]>([]);

  const parseCSV = async () => {
    try {
      const response = await fetch('/umap_all_cells.csv');
      const text = await response.text();

      Papa.parse(text, {
        header: true,
        dynamicTyping: true,
        complete: (result: any) => {
          const data: DataPoint[] = result.data.map((row: any) => ({
            x: parseFloat(row.x),
            y: parseFloat(row.y),
            labels: parseInt(row.labels),
            pointIndex: parseInt(row.point_index),
            barcode: row.barcode
          }));
          setChartData(data);
        },
      });
    } catch(error) {
      console.error('Error fetching CSV file:', error);
    }
  };

  const downsampleData = (data: DataPoint[], sampleSize: number): DataPoint[] => {
    // downsampling logic: take every nth data point
    const downsampled = [];
    for (let i = 0; i < data.length; i += sampleSize) {
      downsampled.push(data[i]);
    }
    return downsampled;
  };

  useEffect(() => {
    parseCSV(); 
  }, []); 

  useEffect(() => {
    const downsampled = downsampleData(chartData, 10); 
    setDownsampledData(downsampled);
  }, [chartData]);

  return (
    <div>
      <h1 className='p-2 mb-5'>UMAP Scatter Plot</h1>
      <div>
      {downsampledData.length > 0 && <UmapScatterChart data={downsampledData} />}
      </div>
    </div>
  );
};

export default CsvParser;
