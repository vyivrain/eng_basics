import React from 'react'
import { shallow, mount, render } from 'enzyme';

import FibNumberExistForm from 'FibNumberExistForm';

describe('FibNumberExistForm', () => {
  it('renders without crashing', () => {
    const fibListEquality = shallow(<FibNumberExistForm/>);
    expect(fibListEquality.find('form').exists()).toBe(true);
  });

  it('handles changes', () => {
    const spy = jest.spyOn(FibNumberExistForm.prototype, 'handleSubmit');
    const wrapper = shallow(<FibNumberExistForm/>);
    const equalityInput = wrapper.find('[data-eq-input]');

    equalityInput.simulate('change', { target: { value: '1' } });
    expect(wrapper.state('numberValue')).toEqual('1');

    wrapper.find('form').simulate('submit', { preventDefault: () => {} });
    expect(spy).toBeCalled();
  });
});
