-- Drop tables in reverse order of dependencies to avoid foreign key issues
DROP TABLE IF EXISTS "public"."predictions";
DROP TABLE IF EXISTS "public"."prediction_reviews";
DROP TABLE IF EXISTS "public"."reports";
DROP TABLE IF EXISTS "public"."projects";

-- Create tables
CREATE TABLE "public"."projects" (
    "id" uuid NOT NULL,
    "name" text,
    "client" text,
    "status" text,
    "description" text,
    "projectType" text,
    "clientIndustry" text,
    "techStack" text[],
    "teamSize" text,
    "duration" text,
    "keywords" text,
    "businessSpecification" text,
    "reportGenerated" boolean,
    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "public"."prediction_reviews" (
    "id" uuid NOT NULL,
    "projectId" uuid,
    "projectName" text,
    "clientName" text,
    "generatedAt" timestamp with time zone,
    CONSTRAINT "prediction_reviews_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "public"."predictions" (
    "id" uuid NOT NULL,
    "aiGeneratedId" text,
    "type" text,
    "title" text,
    "description" text,
    "similarityScore" double precision,
    "frequency" integer,
    "sourceProject" text,
    "status" text,
    "acceptanceCriteria" text[],
    "dependencies" text[],
    "assumptions" text[],
    "edgeCases" text[],
    "nonFunctionalRequirements" text,
    "visuals" text[],
    "dataRequirements" text,
    "impact" text,
    "priority" text,
    "estimatedTime" double precision,
    "stepsToReproduce" text[],
    "actualResult" text,
    "expectedResult" text,
    "environment" text,
    "userAccountDetails" text,
    "screenshotsVideos" text[],
    "errorMessagesLogs" text,
    "frequencyOfOccurrence" text,
    "severity" text,
    "workaround" text,
    "relatedIssues" text[],
    "review_id" uuid,
    CONSTRAINT "predictions_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "predictions_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."prediction_reviews"("id")
);

CREATE TABLE "public"."reports" (
    "id" uuid NOT NULL,
    "project_id" uuid,
    "completion_rate" numeric,
    "status_distribution" jsonb,
    "predictions_count" integer,
    "prediction_type_distribution" jsonb,
    "project_type_distribution" jsonb,
    "client_industry_distribution" jsonb,
    "team_size_distribution" jsonb,
    "duration_distribution" jsonb,
    "total_predictions_count" integer,
    "average_predictions_per_project" numeric,
    "prediction_status_distribution" jsonb,
    "prediction_priority_distribution" jsonb,
    "prediction_severity_distribution" jsonb,
    "average_estimated_time" numeric,
    "top_keywords" text[],
    "tech_stack_list" text[],
    "created_at" timestamp with time zone DEFAULT now(),
    CONSTRAINT "reports_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "reports_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE
);