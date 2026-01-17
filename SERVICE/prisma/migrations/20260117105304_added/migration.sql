/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "CompanyAuth" (
    "companyAuthId" TEXT NOT NULL,
    "adminEmail" TEXT NOT NULL,
    "verificationStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "token" TEXT,

    CONSTRAINT "CompanyAuth_pkey" PRIMARY KEY ("companyAuthId")
);

-- CreateTable
CREATE TABLE "CompanyProfile" (
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "longTermGoals" TEXT NOT NULL,
    "philosophy" TEXT NOT NULL,
    "avoid" TEXT NOT NULL,
    "perform" TEXT NOT NULL,
    "shortTermGoals" TEXT NOT NULL,

    CONSTRAINT "CompanyProfile_pkey" PRIMARY KEY ("companyId")
);

-- CreateTable
CREATE TABLE "CompanyAdministrator" (
    "companyAdministratorId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" TEXT NOT NULL,

    CONSTRAINT "CompanyAdministrator_pkey" PRIMARY KEY ("companyAdministratorId")
);

-- CreateTable
CREATE TABLE "CompanyEmployee" (
    "companyEmployeeId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "administratorId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "role" TEXT NOT NULL,

    CONSTRAINT "CompanyEmployee_pkey" PRIMARY KEY ("companyEmployeeId")
);

-- CreateTable
CREATE TABLE "CompanySOP" (
    "sopId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "duration" TEXT NOT NULL,
    "goals" TEXT NOT NULL,
    "avoid" TEXT NOT NULL,
    "perform" TEXT NOT NULL,

    CONSTRAINT "CompanySOP_pkey" PRIMARY KEY ("sopId")
);

-- CreateTable
CREATE TABLE "SOPSteps" (
    "sopStepId" TEXT NOT NULL,
    "sopId" TEXT NOT NULL,
    "stepCount" INTEGER NOT NULL,
    "stepDescription" TEXT NOT NULL,
    "stepDos" TEXT NOT NULL,
    "stepsDonts" TEXT NOT NULL,

    CONSTRAINT "SOPSteps_pkey" PRIMARY KEY ("sopStepId")
);

-- CreateTable
CREATE TABLE "CompanySOPAssignment" (
    "sopStepId" TEXT NOT NULL,
    "employeeId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CompanySOPAssignment_pkey" PRIMARY KEY ("sopStepId","employeeId")
);

-- CreateTable
CREATE TABLE "SOPTaskLogs" (
    "logId" TEXT NOT NULL,
    "sopStepId" TEXT NOT NULL,
    "approach" TEXT NOT NULL,
    "resolveStatus" TEXT NOT NULL,
    "achievements" TEXT NOT NULL,
    "problems" TEXT,

    CONSTRAINT "SOPTaskLogs_pkey" PRIMARY KEY ("logId")
);

-- CreateTable
CREATE TABLE "SopAnalysis" (
    "analysisId" TEXT NOT NULL,
    "sopId" TEXT NOT NULL,
    "suggestion" TEXT NOT NULL,
    "good" TEXT NOT NULL,
    "bad" TEXT NOT NULL,

    CONSTRAINT "SopAnalysis_pkey" PRIMARY KEY ("analysisId")
);

-- CreateTable
CREATE TABLE "SopLogAnalysis" (
    "analysisId" TEXT NOT NULL,
    "logId" TEXT NOT NULL,
    "suggestions" TEXT NOT NULL,
    "good" TEXT NOT NULL,
    "bad" TEXT NOT NULL,

    CONSTRAINT "SopLogAnalysis_pkey" PRIMARY KEY ("analysisId")
);

-- CreateTable
CREATE TABLE "SopEmployeeAnalysis" (
    "analysisId" TEXT NOT NULL,
    "employeeId" TEXT NOT NULL,
    "suggestions" TEXT NOT NULL,
    "good" TEXT NOT NULL,
    "bad" TEXT NOT NULL,

    CONSTRAINT "SopEmployeeAnalysis_pkey" PRIMARY KEY ("analysisId")
);

-- CreateIndex
CREATE UNIQUE INDEX "CompanyAuth_adminEmail_key" ON "CompanyAuth"("adminEmail");

-- CreateIndex
CREATE UNIQUE INDEX "CompanyAdministrator_email_key" ON "CompanyAdministrator"("email");

-- CreateIndex
CREATE UNIQUE INDEX "CompanyEmployee_email_key" ON "CompanyEmployee"("email");

-- AddForeignKey
ALTER TABLE "CompanyAdministrator" ADD CONSTRAINT "CompanyAdministrator_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "CompanyProfile"("companyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyEmployee" ADD CONSTRAINT "CompanyEmployee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "CompanyProfile"("companyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyEmployee" ADD CONSTRAINT "CompanyEmployee_administratorId_fkey" FOREIGN KEY ("administratorId") REFERENCES "CompanyAdministrator"("companyAdministratorId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanySOP" ADD CONSTRAINT "CompanySOP_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "CompanyProfile"("companyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SOPSteps" ADD CONSTRAINT "SOPSteps_sopId_fkey" FOREIGN KEY ("sopId") REFERENCES "CompanySOP"("sopId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanySOPAssignment" ADD CONSTRAINT "CompanySOPAssignment_sopStepId_fkey" FOREIGN KEY ("sopStepId") REFERENCES "SOPSteps"("sopStepId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanySOPAssignment" ADD CONSTRAINT "CompanySOPAssignment_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "CompanyEmployee"("companyEmployeeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SOPTaskLogs" ADD CONSTRAINT "SOPTaskLogs_sopStepId_fkey" FOREIGN KEY ("sopStepId") REFERENCES "SOPSteps"("sopStepId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SopAnalysis" ADD CONSTRAINT "SopAnalysis_sopId_fkey" FOREIGN KEY ("sopId") REFERENCES "CompanySOP"("sopId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SopLogAnalysis" ADD CONSTRAINT "SopLogAnalysis_logId_fkey" FOREIGN KEY ("logId") REFERENCES "SOPTaskLogs"("logId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SopEmployeeAnalysis" ADD CONSTRAINT "SopEmployeeAnalysis_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "CompanyEmployee"("companyEmployeeId") ON DELETE RESTRICT ON UPDATE CASCADE;
