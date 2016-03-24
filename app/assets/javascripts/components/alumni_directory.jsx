var AlumniDirectory = React.createClass({
  getInitialState: function() {
    return {
      alumni: this.props.users,
      index:  algoliasearch(
                this.props.algolia_application_id,
                this.props.algolia_search_only_api_key
              ).initIndex('AlumniDirectory')
     };
  },

  render: function() {
    return (
      <div>
        <AlumniSearch index={this.state.index} />
        <AlumniList users={this.state.alumni} />
      </div>
    );
  }
});
