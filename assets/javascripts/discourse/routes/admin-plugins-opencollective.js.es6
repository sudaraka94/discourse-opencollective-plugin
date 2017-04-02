import FilterRule from 'discourse/plugins/discourse-opencollective-plugin/discourse/models/filter-rule';
import { ajax } from 'discourse/lib/ajax';

export default Discourse.Route.extend({
  model() {
    return ajax("/admin/plugins/opencollective/list.json")
    .then(function(result) {
      var final = result.opencollective;

      return final.map(function(v) {
        return FilterRule.create(v);
      });
    });
  }
});