const { get_yearly_configs } = require('./shared');

get_yearly_configs('2022').then(function (ret) {
  console.log(ret['2022'].contributors);
});
