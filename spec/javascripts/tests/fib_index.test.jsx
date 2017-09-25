import React from 'react'
import { shallow, mount, render } from 'enzyme';
import FibIndex from 'FibIndex';

describe('FibIndex', () => {
  it('renders without crashing', () => {
    expect(shallow(<FibIndex />).contains(
      <thead>
        <tr>
          <th className="text-center">Items</th>
          <th className="text-center">Created</th>
          <th className="text-center">Actions</th>
        </tr>
      </thead>
    )).toBe(true);
  });

  it('should render table content', () => {
    const fibIndex = shallow(<FibIndex/>);
    fibIndex.setState({ fibs: [{ id: 1, items_str: '[0, 1, 1, 2]', created_at_format: '02/11/19' }] });
    expect(fibIndex.find('[data-items]').text()).toEqual('[0, 1, 1, 2]');
    expect(fibIndex.find('[data-created-format]').text()).toEqual('02/11/19');
  });

  it('should show loading', () => {
    const fibIndex = shallow(<FibIndex/>);
    expect(fibIndex.find('[data-items]').text()).toEqual('Loading...');
    expect(fibIndex.find('[data-created-format]').text()).toEqual('Loading...');
  });
});