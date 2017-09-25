import React from 'react'
import { shallow, mount, render } from 'enzyme';
import FibShow from 'FibShow';

describe('FibShow', () => {
  it('renders without crashing', () => {
    expect(shallow(<FibShow/>).contains(
      <thead>
        <tr>
          <th className="text-center">Item List</th>
          <th className="text-center">Element exists in item list</th>
          <th className="text-center">Item List equality to another list</th>
          <th className="text-center">Fib sum square</th>
        </tr>
      </thead>
    )).toBe(true);
  });

  it('renders fib loading data', () => {
    const fibShow = shallow(<FibShow />);
    expect(fibShow.find('[data-item]').text()).toEqual('Loading...');
    expect(fibShow.find('[data-fib-square]').text()).toEqual('Loading...');
  });

  it('renders fib item data', () => {
    const fibShow = shallow(<FibShow />);
    fibShow.setState({ fib: { id: 1, items_str: '[0, 1, 1, 2]', known_fib_square: '4' } });
    expect(fibShow.find('[data-item]').text()).toEqual('[0, 1, 1, 2]');
    expect(fibShow.find('[data-fib-square]').text()).toEqual('4');
  });
});

