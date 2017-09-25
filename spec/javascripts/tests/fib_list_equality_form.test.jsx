import React from 'react'
import { shallow, mount, render } from 'enzyme';

import FibListEqualityForm from 'FibListEqualityForm';

describe('FibListEqualityForm', () => {
  it('renders without crashing', () => {
    const fibListEquality = shallow(<FibListEqualityForm/>);
    expect(fibListEquality.find('form').exists()).toBe(true);
  });

  it('handles changes', () => {
    const spy = jest.spyOn(FibListEqualityForm.prototype, 'handleSubmit');
    const wrapper = shallow(<FibListEqualityForm/>);

    const equalityInput = wrapper.find('[data-eq-input]');

    equalityInput.simulate('change', { target: { value: '1, 2, 3, 4, 5' } });
    expect(wrapper.state('listValue')).toEqual('1, 2, 3, 4, 5');

    wrapper.find('form').simulate('submit', { preventDefault: () => {} });
    expect(spy).toBeCalled();
  });
});
