import { Products } from './components/Products';
import { Payments } from './components/Payments';

function App() {
  return (
    <div style={{ fontFamily: 'system-ui, sans-serif', padding: '20px' }}>
      <h1>Sklep internetowy React</h1>
      <Products />
      <hr />
      <Payments />
    </div>
  )
}

export default App;
