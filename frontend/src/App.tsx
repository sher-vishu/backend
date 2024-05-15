import { useState } from 'react';
import CsvParser from './features/chart/CsvParser';
import { DataPoint } from './types/types'; 

function App() {
  const [chartData, setChartData] = useState<DataPoint[]>([]);

  const handleDataParsed = (data: DataPoint[]) => {
    setChartData(data);
  };

  return (
    <div className="App">
      <h1>UMAP Scatter Chart</h1> 
     <CsvParser onDataParsed={handleDataParsed} />
    </div>
  );
};

export default App;