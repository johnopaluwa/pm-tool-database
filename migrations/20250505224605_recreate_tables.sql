CREATE TABLE public.workflow_stages (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    workflow_id uuid NOT NULL,
    name text NOT NULL,
    "order" integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.stage_statuses (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    stage_id uuid NOT NULL,
    name text NOT NULL,
    "order" integer NOT NULL,
    is_default boolean DEFAULT false,
    is_completion_status boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.custom_field_values (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    field_id uuid NOT NULL,
    entity_id uuid NOT NULL,
    value text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.prediction_reviews (
    id uuid NOT NULL,
    "projectId" uuid,
    "projectName" text,
    "clientName" text,
    "generatedAt" timestamp with time zone
);

CREATE TABLE public.reports (
    id uuid NOT NULL,
    project_id uuid,
    completion_rate numeric,
    status_distribution jsonb,
    predictions_count integer,
    prediction_type_distribution jsonb,
    created_at timestamp with time zone DEFAULT now(),
    project_type_distribution jsonb,
    client_industry_distribution jsonb,
    team_size_distribution jsonb,
    duration_distribution jsonb,
    total_predictions_count integer,
    average_predictions_per_project numeric,
    prediction_status_distribution jsonb,
    prediction_priority_distribution jsonb,
    prediction_severity_distribution jsonb,
    average_estimated_time numeric,
    top_keywords text[],
    tech_stack_list text[]
);

CREATE TABLE public.projects (
    id uuid NOT NULL,
    name text,
    client text,
    status text,
    description text,
    "projectType" text,
    "clientIndustry" text,
    "techStack" text[],
    "teamSize" text,
    duration text,
    keywords text,
    "businessSpecification" text,
    "reportGenerated" boolean,
    workflow_id uuid
);

CREATE TABLE public.tasks (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    project_id uuid,
    title text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    status_id uuid
);

CREATE TABLE public.predictions (
    id uuid NOT NULL,
    "aiGeneratedId" text,
    type text,
    title text,
    description text,
    "similarityScore" double precision,
    frequency integer,
    "sourceProject" text,
    status text,
    "acceptanceCriteria" text[],
    dependencies text[],
    assumptions text[],
    "edgeCases" text[],
    "nonFunctionalRequirements" text,
    visuals text[],
    "dataRequirements" text,
    impact text,
    priority text,
    "estimatedTime" double precision,
    "stepsToReproduce" text[],
    "actualResult" text,
    "expectedResult" text,
    environment text,
    "userAccountDetails" text,
    "screenshotsVideos" text[],
    "errorMessagesLogs" text,
    "frequencyOfOccurrence" text,
    severity text,
    workaround text,
    "relatedIssues" text[],
    review_id uuid
);

CREATE TABLE public.organizations (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.workflows (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    description text
);

CREATE TABLE public.custom_field_definitions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    entity_type text NOT NULL,
    options jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY public.workflow_stages
    ADD CONSTRAINT workflow_stages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.stage_statuses
    ADD CONSTRAINT stage_statuses_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.custom_field_values
    ADD CONSTRAINT custom_field_values_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.prediction_reviews
    ADD CONSTRAINT prediction_reviews_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.custom_field_definitions
    ADD CONSTRAINT custom_field_definitions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.workflow_stages
    ADD CONSTRAINT workflow_stages_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.workflows(id);

ALTER TABLE ONLY public.stage_statuses
    ADD CONSTRAINT stage_statuses_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.workflow_stages(id);

ALTER TABLE ONLY public.custom_field_values
    ADD CONSTRAINT custom_field_values_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.custom_field_definitions(id);

ALTER TABLE ONLY public.predictions
    ADD CONSTRAINT predictions_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.prediction_reviews(id);

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.stage_statuses(id);

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.workflows(id);
