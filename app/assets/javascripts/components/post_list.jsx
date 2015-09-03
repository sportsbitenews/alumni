var PostList = React.createClass({
  render: function() {
    return (
      <div ref='postList'>
        <SwipeViews>
          <div className='col-sm-3 posts-column' title="#resources">
          <a href={Routes.new_resource_path()}>
            <div className='posts-column-new'>
              ADD A NEW RESOURCE
            </div>
          </a>
            {this.props.resources.map(resource => {
              var props = _.merge(resource, { key: `${resource.type}-${resource.id}` });
              return React.createElement(ResourceListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#help">
          <a href={Routes.new_question_path()}>
            <div className='posts-column-new'>
              ASK A NEW QUESTION
            </div>
          </a>
            {this.props.questions.map(question => {
              var props = _.merge(question, { key: `${question.type}-${question.id}` });
              return React.createElement(QuestionListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#jobs">
            <a href={Routes.new_job_path()}>
              <div className='posts-column-new'>
                ADD A NEW JOB
              </div>
            </a>
            {this.props.jobs.map(job => {
              var props = _.merge(job, { key: `${job.type}-${job.id}` });
              return React.createElement(JobListElement, props);
            })}
          </div>
          <div className='col-sm-3 posts-column' title="#milestones">
            <a href={this.props.current_user.can_post_milestone ? Routes.new_milestone_path() : 'mailto:ssaunier@gmail.com'}>
            <div className='posts-column-new'>
            {this.props.current_user.can_post_milestone ? 'ADD A NEW MILESTONE' : 'SUBMIT A NEW PRODUCT'}
            </div>
            </a>
            {this.props.milestones.map(milestone => {
              var props = _.merge(milestone, { key: `${milestone.type}-${milestone.id}` });
              return React.createElement(MilestoneListElement, props);
            })}
          </div>
        </SwipeViews>
      </div>
    );
  }
});
