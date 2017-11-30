# This is common "config" for all the kinder surveys.

use SD::Common;
use List::MoreUtils qw/ uniq /;

my $common = {
    clinic_access_uuid => '4c154829-eab6-97c8-bdbb-472728fd0f7d',
    group_access_uuid  => '830d989c-e619-00d3-dcd0-6a5eb36ac851',
    admin_site_urls => {
        development => 'http://mash.fz.sdlocal.net:5557',
        testing     => 'http://websurvey-admin-testing.dc.sdlocal.net',
        staging     => 'http://websurvey-admin-staging.dc.sdlocal.net',
        production  => 'https://link-me-admin.websurvey.net.au',
    },
    admin_site_https_urls => {
        development => 'http://mash.fz.sdlocal.net:5557',
        testing     => 'https://admin.testing.websurvey.net.au',
        staging     => 'https://admin.staging.websurvey.net.au',
        production  => 'https://link-me-admin.websurvey.net.au',
    },
    as_json => sub {
        my $data = shift;
        my $json = JSON::XS->new;
        return $json->encode($data);
    },
    store_list_difficult => sub {
      my $session = shift;
      my $config  = SD::Config->load;

      my $areas = $config->{intervention_areas};
      my $q2    = $session->get('q2');

      my $list_difficult_one;
      my $list_difficult_two;

      if ($q2) {
        $list_difficult_one = $q2->[0] if $q2->[0];
        $list_difficult_two = $q2->[1] if $q2->[1];
      } else {
        my $difficult_areas = $config->{get_difficult_areas}->($session);
        $list_difficult_one = $difficult_areas->[0] if $difficult_areas->[0];
        $list_difficult_two = $difficult_areas->[1] if $difficult_areas->[1];
      }

      $session->set(list_difficult1 => $areas->{$list_difficult_one}->{sentence_text})
        if $list_difficult_one;
      $session->set(list_difficult2 => $areas->{$list_difficult_two}->{sentence_text})
        if $list_difficult_two;
    },
    get_group => sub {
      my $session = shift;

      my $conf       = SD::Config->load();
      my $agent      = LWP::UserAgent->new;
      my $deployment = $conf->{surveymeta}->{deployment} || 'development';
      my $url        = $conf->{admin_site_urls}->{$deployment};
      my $uuid       = $conf->{group_access_uuid};

      my $session_key = $session->get('session_key');
      my $severity    = $session->get('severity');

      my $response =  `curl -s -d "severity=$severity&session_key=$session_key&uuid=$uuid" -X POST "$url/unimelb/link_me/group/public"`;

      # XXX: Error check this.
      return unless $response;
      my $json = JSON::XS->new->decode($response);

      return $json->{group_name};
    },
    calculate_severity => sub {
      my $session = shift;
      my $anxiety    = $session->get('gad1') + $session->get('gad2');
      my $depression = $session->get('phq1') + $session->get('phq2');

      my $limit = 2;

      my $phqdep_total        = $session->get('phqdep_total');
      my $gad_total           = $session->get('gad_total');
      my $gad_max             = $session->get('gad_max');
      my $ever_depressed      = $session->get('ever_depressed');
      my $live_alone          = $session->get('live_alone');
      my $gender_collapse     = $session->get('gender_collapsed');
      my $chronic             = $session->get('chronic');
      my $sf1_health_collapse = $session->get('sf1_health_collapse');
      my $inc_mg_collapse     = $session->get('inc_mg_collapse');

      # Mild/Moderate/Severe
      my $severity_level;
      if ($depression >= $limit) {
        # Check depression algorithm
        my $depression_predict = 3.5 +
                                 0.5  * $phqdep_total +
                                 1.57 * ($ever_depressed == 1) +
                                 0.74 * ($gad_max == 1) +
                                 1.54 * ($gad_max == 2) +
                                 1.15 * ($chronic == 1) +
                                 0.74 * ($sf1_health_collapse == 4) +
                                 2.17 * ($sf1_health_collapse == 5) +
                                 0.85 * ($live_alone == 1) +
                                 1.15 * ($inc_mg_collapse == 1) +
                                 -0.68 * ($gender_collapse == 1);

        $session->set(depression_predict => $depression_predict);

        if ($depression_predict < 10.5) {
          $severity_level = 'Mild_D';
        } elsif ($depression_predict >= 10.5 && $depression_predict <= 12.5) {
          $severity_level = 'Moderate_D';
        } else {
          $severity_level = 'Severe_D';
        }
      }

      if ($anxiety >= $limit) {
        my $anxiety_predict = 2.4 +
                              0.25 * $phqdep_total +
                              0.18 * $gad_total +
                              0.82 * ($ever_depressed == 1) +
                              1.19 * ($live_alone == 1) +
                              0.37 * ($gender_collapse == 1);

        $session->set(anxiety_predict => $anxiety_predict);

        if ($anxiety_predict < 7.5) {
          # If anxiety was already Mild, this makes both Mild.
          if ($severity_level eq 'Mild_D') {
            $severity_level = 'Mild_DA';
          } elsif (!$severity_level) {
            $severity_level = 'Mild_A';
          }
        } elsif ($anxiety_predict >= 7.5 && $anxiety_predict <= 9 && $severity_level ne 'Severe_D') {
          if ($severity_level eq 'Mild_D' || !$severity_level) {
            $severity_level = 'Moderate_A';
          } else {
            $severity_level = 'Moderate_DA';
          }
        } elsif ($anxiety_predict > 9) {
          if ($severity_level eq 'Severe_D') {
            $severity_level = 'Severe_DA';
          } else {
            $severity_level = 'Severe_A';
          }
        }
      }

      return $severity_level;
    },

    get_difficult_areas => sub {
      my $session = shift;
      my $config = SD::Config->load;

      my $intervention_areas = $config->{intervention_areas};
      my @difficult_areas    = ();
      for my $area (keys %$intervention_areas) {
        if ($intervention_areas->{$area}->{difficult}->($session)) {
          push @difficult_areas, $area;
        }
      }

      return \@difficult_areas;
    },

    get_ok_areas => sub {
      my $session = shift;
      my $config = SD::Config->load;

      my $intervention_areas = $config->{intervention_areas};
      my @ok_areas = ();
      for my $area (keys %$intervention_areas) {
        if ($intervention_areas->{$area}->{ok}->($session)) {
          push @ok_areas, $area;
        }
      }

      return \@ok_areas;
    },

    intervention_areas => {
      interest => {
        option_text   => 'Little Interest',
        sentence_text => 'interest or pleasure in doing things',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq1');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq1');
          return ($value == 2 || $value == 3);
        },
      },
      mood => {
        option_text   => 'Mood',
        sentence_text => 'mood',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq2');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq2');
          return ($value == 2 || $value == 3);
        },
      },
      sleep => {
        option_text   => 'Sleep',
        sentence_text => 'sleep',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq3');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq3');
          return ($value == 2 || $value == 3);
        },
      },
      energy => {
        option_text   => 'Energy',
        sentence_text => 'energy',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq4');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq4');
          return ($value == 2 || $value == 3);
        },
      },
      appetite => {
        option_text   => 'Appetite',
        sentence_text => 'appetite',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq5');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq5');
          return ($value == 2 || $value == 3);
        },
      },
      image => {
        option_text   => 'Self-image',
        sentence_text => 'self-image',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq6');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq6');
          return ($value == 2 || $value == 3);
        },
      },
      concentration => {
        option_text   => 'Concentration',
        sentence_text => 'concentration',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq7');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq7');
          return ($value == 2 || $value == 3);
        },
      },
      movement => {
        option_text   => 'Movement',
        sentence_text => 'movement',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('phq8');
          return ($value == 0 || $value == 1);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq8');
          return ($value == 2 || $value == 3);
        },
      },
      death => {
        option_text   => 'Thought of death',
        sentence_text => 'thoughts of self-harm or death',
        ok => sub {
          return 0; # never show
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('phq9');
          return ($value == 2 || $value == 3);
        },
      },
      anxiety => {
        option_text   => 'Anxiety',
        sentence_text => 'anxiety',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('gad1') + $session->get('gad2') +
                        $session->get('gad3') + $session->get('gad4') +
                        $session->get('gad5') + $session->get('gad6') +
                        $session->get('gad7');

          return ($value < 10);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('gad1') + $session->get('gad2') +
                        $session->get('gad3') + $session->get('gad4') +
                        $session->get('gad5') + $session->get('gad6') +
                        $session->get('gad7');
          return ($value >= 10);
        },
      },
      health => {
        option_text   => 'Health',
        sentence_text => 'health',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('sf1_health');
          return ($value == 1 || $value == 2 || $value == 3);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('sf1_health');
          return ($value == 4 || $value == 5);
        },
      },
      activities => {
        option_text   => 'Daily Activities',
        sentence_text => 'ability to complete daily activities',
        ok => sub {
          my $session = shift;
          return ($session->get('chronic') == 0);
        },
        difficult => sub {
          my $session = shift;
          return ($session->get('chronic') == 1);
        },
      },
      economy => {
        option_text   => 'Finances',
        sentence_text => 'ability to manage on your available income',
        ok => sub {
          my $session = shift;
          my $value   = $session->get('inc_mg');
          return ($value == 1 || $value == 2 || $value == 3);
        },
        difficult => sub {
          my $session = shift;
          my $value   = $session->get('inc_mg');
          return ($value == 4 || $value == 5);
        },
      },
    },
    find_session => sub {
        my ($component_name, $key, $value) = @_;

        # Get the component config
        my $conf = SD::Config->load(); # config for *this* component
        my $component_conf = $conf->{get_component_config}->( $component_name );

        my $query = <<"SQL";
SELECT session_key, var.name AS name, COALESCE(int_val, perl_val) AS val
  FROM session
    LEFT JOIN survey ON ( session.survey_id = survey.id )
    LEFT JOIN answer ON ( answer.session_id = session.id )
    LEFT JOIN var ON ( answer.var_id = var.id AND var.survey_id = survey.id )
  WHERE survey.name = ? AND var.name = ? AND COALESCE(int_val, perl_val) = ?
SQL

        my $dbh      = SD::DBH->get_dbh();
        my ($result) = $dbh->selectrow_array($query, {}, $component_conf->{survey_name}, $key, $value);

        return $result;
    },

    get_sessions_where => sub {
        my ($component_name, $values) = @_;
        die "No name (path) specified for component conf" unless $component_name;
        $values ||= {};

        # Get the component config
        my $conf = SD::Config->load(); # config for *this* component
        my $component_conf = $conf->{get_component_config}->( $component_name );

        # Check vars are sane (upper/lower case,underscore and hyphen only)
        my $var_string = join(', ', map {
            die "Not valid var name ($_)" if $_ !~ /^[a-z][\w-]*$/i;
            "'$_'" } uniq ( keys %$values, 'session_key' ) );

        # Build subquery to that only involves the vars and a unique 'val' field
        # We have sufficient indexes to make this efficient..
        my $subquery = <<"SQL";
SELECT session_key, var.name AS name, COALESCE(int_val, perl_val) AS val
  FROM session
    LEFT JOIN survey ON ( session.survey_id = survey.id )
    LEFT JOIN answer ON ( answer.session_id = session.id )
    LEFT JOIN var ON ( answer.var_id = var.id AND var.survey_id = survey.id )
  WHERE survey.name = ?
    AND var.name IN ( $var_string )
SQL


        my $pivot_columns;
        if ( scalar keys %$values ) {
            $pivot_columns = join(", ",
               map { "GROUP_CONCAT(IF(name='$_',val,NULL)) AS '$_'" }
                 grep { $_ ne 'session_key' } keys %$values );
        }

        # Build the outer query, group by session key having our values
        my $query = "SELECT session_key";
        $query .= ", $pivot_columns" if defined $pivot_columns;
        $query .= " FROM ( $subquery ) AS DerivedTable1 GROUP BY session_key HAVING ";
        my @vars = ();
        my @bind = ();
        while ( my ($var, $val) = each %$values ) {
            push @vars, "$var = ?";
            push @bind, $val;
        }
        $query .= join(' AND ', @vars);

        my $dbh = SD::DBH->get_dbh();
        return $dbh->selectcol_arrayref( $query, {}, $component_conf->{survey_name}, @bind );
    },

    # Fetch a child components config (used everywhere)
    get_component_config => sub {
        my $component = shift; # either a component path or component id (survey_name)
        die "No name (component path) specified" unless $component;
        my $conf = SD::Config->load(); # config for *this* component
        # If this survey has no meta, use component name in relative path search
        # (for backwards compatibility)
        my $child_directory = exists $conf->{surveymeta} ?
            $conf->{surveymeta}{components}{$component} : $component;
        die "No component id found for name $component" unless $child_directory;
        my $child_path = $conf->{conf_dir}->parent->parent->file(
            $child_directory,'conf','config.pl')->resolve->stringify;
        return SD::Config->load($child_path);
    },

    # Create a session in a(nother) component by name (path) or id
    create_component_session => sub {
        my ( $component, $skey ) = @_;
        die "No name (path) or id specified for component conf" unless $component;
        my $conf = SD::Config->load(); # config for *this* component
        my $component_conf = $conf->{get_component_config}->( $component );
        # Path to the components config.pl
        my $child_path = $component_conf->{'conf_dir'}->file('config.pl')->stringify;
        my $ses_class  = $component_conf->{class}{session};
        my $child_session;
        {
            local $ENV{SD_CONF_FILE} = $child_path;
            $child_session = $ses_class->create($skey);
        }
        return $child_session;
    },

    # Fetch a session from a component [ name (path) or id ]
    fetch_session => sub {
        my ($session_key, $component) = @_;
        my $conf = SD::Config->load(); # config for *this* component
        my $component_conf = {};
        if ( defined $component ) {
            $component_conf = $conf->{get_component_config}->( $component );
        }
        my $survey_name = $component_conf->{survey_name} || $conf->{survey_name};
        my $session;
        # Fetch
        eval { $session = SD::Session::Cached->fetch($session_key, $survey_name) };
        return $session if $session;
        return undef;
    },

    crud_add => sub {
        my ( $conf, $session, $component_name ) = @_;

        # create new session in $component_name
        my $new_session = $conf->{create_component_session}->($component_name);
        die "Failed to create component session" unless $new_session;

        # keep track of the last session added
        # so we can display it instantly if required
        $session->set(last_session_added => {
            component   => $component_name,
            session_key => $new_session->{session_key},
        });

        # set the parent_session in the new ses
        $new_session->set(parent_session => $session->get('session_key'));

        # "link to parents->parent"
        if ($session->get('parent_session')) {
            $new_session->set(base_session => $session->get('parent_session'));
        }

        return $new_session;
    },

    crud_delete => sub {
        my ( $conf, $ses, $args, $component_name ) = @_;

        # Fetch skey from args
        my ( $component ) = keys %{ $args };
        my ( $skey ) = keys %{ $args->{ $component_name } };

        # Inflate component session
        my $component_conf = $conf->{get_component_config}->( $component_name );
        my $ses_class = $component_conf->{class}{session};
        my $component_ses;
        eval { $component_ses = $ses_class->fetch($skey, $component_conf->{survey_name} ); };
        die E->new($@) if $@;
        # Ensure child session has this parent
        my $parent = $component_ses->get('parent_session');
        if ( $parent ne $ses->get('session_key') ) {
            die E->new("This session and the child session have inconsistent relationships");
        }
        # Flag component session as deleted
        $component_ses->set('considered_complete' => '-1');
    },

    url_to_pdf => sub {
        my $url = shift;
        my $pdf = SD::PrinceXML::Client->new(
            url              => $url,
            input            => 'html',
            network          => 1,
            send_literal_url => 1,
        )->pdf;
        return $pdf;
    },
		walk_between_pages => sub {
			# last_page = regex
			my ($session, $start_page, $last_page) = @_;

			# reduce risk of unintended access to *real* session, key for debugging
			local $ENV{SD_KEY} = 'walk_pages_session_access_violation';

			my $conf = SD::Config->load();

			my @pagelist = ( $conf->{ pages }->{ $start_page } );
			$session->set('page' => $start_page );

			my $nav = SD::Navigator->new(
					$conf->{ pages },
					$session,
					{
							%{ $conf->{ nav_args } || {} },
							hooks => 0,
					},
			);
			my $current_page = $start_page;
			my $prev_page = '';
			eval {
					while ( $prev_page ne $current_page ) {
							last if $current_page =~ /$last_page/;
							$prev_page = $current_page;
							$current_page = $nav->do('next');
							push @pagelist, $conf->{ pages }->{ $current_page };
					}
			};

			if ($@) {
					my $error = "Page $current_page\n";
					$error .= "$@";
					warn $error;
			}

			return \@pagelist;
		},
    walk_pages => sub {
			my ($session, $component_name) = @_;


			# reduce risk of unintended access to *real* session, key for debugging
			local $ENV{SD_KEY} = 'walk_pages_session_access_violation';

      my $conf = SD::Config->load(); # config for *this* component
      my $component_conf = $conf->{get_component_config}->( $component_name );

			my @pagelist = ( $component_conf->{ pages }->{ start } );
			$session->set('page' => 'start' );

			my $nav = SD::Navigator->new(
					$component_conf->{ pages },
					$session,
					{
							%{ $component_conf->{ nav_args } || {} },
							hooks => 0,
					},
			);
			my $current_page = 'start';
			my $last_page = '';
			eval {
					while ( $last_page ne $current_page ) {
							last if $current_page =~ /(?:last|completed)/;
							$last_page = $current_page;
							$current_page = $nav->do('next');
							push @pagelist, $component_conf->{ pages }->{ $current_page };
					}
			};

			if ($@) {
					my $error = "Page $current_page\n";
					$error .= "$@";
					warn $error;
			}

			return \@pagelist;
    },
};


return $common;
